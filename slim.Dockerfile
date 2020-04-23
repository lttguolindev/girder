FROM python:3.7-slim as runtime
EXPOSE 8080

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
