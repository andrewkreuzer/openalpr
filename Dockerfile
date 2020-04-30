from ubuntu:18.04

# Install prerequisites
run apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl3-dev \
    libleptonica-dev \
    liblog4cplus-dev \
    libopencv-dev \
    wget

# Install Tesseract from ppa
run apt install -y software-properties-common
run apt-add-repository ppa:alex-p/tesseract-ocr
run apt update -y
run apt install -y libtesseract-dev

# Copy all data
copy . /srv/openalpr

# Setup the build directory
run mkdir /srv/openalpr/src/build
workdir /srv/openalpr/src/build

# Setup the compile environment
run cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
    make -j2 && \
    make install

workdir /data

