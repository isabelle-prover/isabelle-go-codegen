FROM docker.io/makarius/isabelle:Isabelle2023

USER root
RUN apt-get -y update && \
  apt-get install -y golang && \
  apt-get clean
USER isabelle

COPY --chown=isabelle:users ROOT *.ML *.thy go-code-gen/
COPY --chown=isabelle:users go_test go-code-gen/go_test/

RUN Isabelle/bin/isabelle build -d go-code-gen Go

ENTRYPOINT Isabelle/bin/isabelle build -v -e -d go-code-gen Go_Test && \
  cd ./go-code-gen/go_test/go && \
  go test  -v ./Interface
