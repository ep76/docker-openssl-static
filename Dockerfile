FROM alpine:3.15 AS builder
ARG openssl_url=https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1o.tar.gz
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

FROM builder AS tester
RUN \
  cd /tmp && \
  ./configdata.pm --command-line | sed 's/no-tests//p;d' | sh && \
  # https://github.com/openssl/openssl/issues/12242
  if uname -m | grep -qE 'armv7l|aarch64'; then TESTS=-test_afalg; fi && \
  make -o configdata.pm test TESTS=${TESTS:-alltests}

FROM scratch AS openssl-static
LABEL maintainer="https://github.com/ep76/docker-openssl-static"
COPY --from=builder /openssl /usr
ENTRYPOINT [ "/usr/bin/openssl" ]
