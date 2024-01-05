FROM docker.io/makarius/isabelle:Isabelle2023

USER root
RUN apt-get -y update && \
  apt-get install -y golang && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
USER isabelle

COPY --chown=isabelle:users ROOT *.ML *.thy go-code-gen/
COPY --chown=isabelle:users document go-code-gen/document/
COPY --chown=isabelle:users test go-code-gen/test/

ENV ISABELLE_GO=/usr/bin/go

ENTRYPOINT Isabelle/bin/isabelle build -v -e -D go-code-gen && \
  cd ./go-code-gen/test/quick/go && \
  go test  -v ./Interface
