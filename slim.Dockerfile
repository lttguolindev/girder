FROM python:3.7-slim as runtime
LABEL maintainer="Kitware, Inc. <kitware@kitware.com>"
EXPOSE 8080

WORKDIR /girder

RUN apt-get update \
  && apt-get install -qy --no-install-recommends \
    libldap2-dev \
    libsasl2-dev \
  && rm -rf /var/lib/apt/lists/*
COPY . /girder/

ARG BUILD_ENV=docker-slim

# avoid psutil GCC dependency by using unofficial large_image wheel
RUN pip install \
  --no-cache-dir \
  --upgrade \
  --find-links https://girder.github.io/large_image_wheels \
  --upgrade-strategy eager .

COPY --from=girder/girder:latest /usr/share/girder/static/ /usr/local/share/girder/static/

ENTRYPOINT ["girder", "serve"]
