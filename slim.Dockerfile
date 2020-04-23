FROM python:3.7-slim as runtime
LABEL maintainer="Kitware, Inc. <kitware@kitware.com>"
EXPOSE 8080

# Set environment to support Unicode: http://click.pocoo.org/5/python3/#python-3-surrogate-handling
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /girder

COPY . ./

ARG BUILD_ENV=docker-slim

# avoid psutil GCC dependency by using unofficial large_image wheel
RUN pip install \
  --no-cache-dir \
  --upgrade \
  --find-links https://girder.github.io/large_image_wheels \
  --upgrade-strategy eager .

COPY --from=girder/girder:latest /usr/share/girder/static/ /usr/local/share/girder/static/

ENTRYPOINT ["girder", "serve"]
