FROM alpine:3.13 AS openssl-builder
ARG openssl_url=https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1k.tar.gz
RUN \
  apk add --no-cache \
    curl \
    gcc \
    linux-headers \
    make \
    musl-dev \
    perl \
    && \
  cd /tmp && \
  curl -fsSL "${openssl_url}" | tar xz --strip-components=1 && \
  ./config \
    no-deprecated \
    no-shared \
    no-tests \
    no-weak-ssl-ciphers \
    -static \
    && \
  make install_sw INSTALLTOP=/openssl

FROM scratch
LABEL maintainer="https://github.com/ep76/openssl-static"
COPY --from=openssl-builder /openssl /usr
ENTRYPOINT [ "/usr/bin/openssl" ]
