FROM docker.io/makarius/isabelle:Isabelle2024

COPY --chown=isabelle:users ROOT *.ML *.thy go-code-gen/
COPY --chown=isabelle:users document go-code-gen/document/
COPY --chown=isabelle:users test go-code-gen/test/

ENV PATH "$PATH:/home/isabelle/Isabelle/bin"

RUN isabelle go_setup

ENTRYPOINT isabelle build -v -e -D go-code-gen && \
  cd ./go-code-gen/test/quick/go && \
  isabelle go test -v ./Interface
