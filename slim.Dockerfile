FROM python:3.7-slim as runtime
EXPOSE 8080

WORKDIR /girder

RUN apt update && apt install -qy gcc git
COPY . /girder/

RUN pip install --upgrade --upgrade-strategy eager .

COPY --from=girder/girder:latest /usr/share/girder/static/ /usr/local/share/girder/static/

ENTRYPOINT ["girder", "serve"]
