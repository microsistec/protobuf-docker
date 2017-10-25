FROM debian:stretch

RUN apt-get update \
    && apt-get upgrade \
    && apt-get dist-upgrade \
    && apt-get install --assume-yes build-essential autoconf libtool libgflags-dev libgtest-dev clang libc++-dev git curl \
    && mkdir /build \
    && git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc /build \
    && cd /build \
    && git submodule update --init \
    && make \
    && make install \
    && cd /build/third_party/protobuf \
    && make \
    && make install \
    && apt-get remove --assume-yes build-essential autoconf libtool libgflags-dev libgtest-dev clang libc++-dev git curl \
    && apt-get autoremove --assume-yes \
    && rm -Rfv /build
