FROM alpine:3.8

RUN apk add --no-cache autoconf automake libtool cmake git make g++ linux-headers

RUN cd /tmp && \
  git clone git://git.openssl.org/openssl.git && \
  cd openssl \
  export KERNEL_BITS=64 && \
  ./Configure linux-generic64 && \
  ./config shared enable-ec_nistp_64_gcc_128 --openssldir=/usr/local/openssl --prefix=/usr/local/openssl && \
  make && make install

ENV LD_LIBRARY_PATH=/usr/local/openssl/lib

ENTRYPOINT ["openssl"]