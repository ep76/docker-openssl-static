# docker-openssl-static

> A Docker image for [OpenSSL](https://www.openssl.org),
> statically compiled with `musl`

[![CI](https://github.com/ep76/docker-openssl-static/actions/workflows/ci.yml/badge.svg?branch=v3)](
  https://github.com/ep76/docker-openssl-static/actions/workflows/ci.yml
)
[![DockerHub](https://img.shields.io/docker/v/ep76/openssl-static/3)](
  https://hub.docker.com/r/ep76/openssl-static/tags?page=1&ordering=last_updated
)

## Usage

### In shell

```shell
$ docker run --rm ep76/openssl-static:latest version
# <version string>
```

### In Dockerfile

```Dockerfile
# For the binary:
COPY --from=ep76/openssl-static:latest /usr/bin/openssl /usr/bin/
# For the libraries and headers:
COPY --from=ep76/openssl-static:latest /usr/lib /usr/include /usr/
```

## License

[MIT](./LICENSE)
