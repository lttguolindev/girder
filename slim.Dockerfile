FROM python:3.7-slim as runtime
EXPOSE 8080

WORKDIR /girder

RUN apt update && apt install -qy gcc git
COPY . /girder/

# TODO: Do we want to create editable installs of plugins as well?  We
# will need a plugin only requirements file for this.
RUN pip install --upgrade --upgrade-strategy eager .

COPY --from=girder/girder:latest /usr/share/girder/static/ /usr/local/share/girder/static/

ENTRYPOINT ["girder", "serve"]
