# Go Code Generation for Isabelle

[![DOI](https://zenodo.org/badge/697269869.svg)](https://zenodo.org/badge/latestdoi/697269869)
[![arXiv](https://img.shields.io/badge/arXiv-2310.02704-b31b1b.svg)](https://arxiv.org/abs/2310.02704)

This repository contains a standalone code generation target for the Go
programming language for use with Isabelle2023.

To use it, simply import the `Go` session defined herein into your own development,
and import the `Go_Setup` theory. Code can then be exported in the usual way with

~~~isabelle
export_code <name> in Go
~~~

which produces code that can be used from Go.

## Trying it out (the quick version)

This repository contains a test session `Go_Test_Quick`. If you have
Isabelle2023 installed, just run the following command:

~~~shell
isabelle build -v -e -d . Go_Test_Quick
~~~

This will build the session and export some sample code to `test/quick/export`.
This will typically take less than a minute (or a few minutes on a slow
machine).

The generated code contains BigInts and a Red Black Tree data structure.

To test the generated code, run the following commands:

~~~shell
cd test/quick/go
go test -v ./Interface
~~~

This should produce some (successful) test output, indicated with `PASS`:

~~~data
go test -v ./Interface
=== RUN   TestTreeFromList
--- PASS: TestTreeFromList (0.00s)
=== RUN   TestJoinAndCheck
--- PASS: TestJoinAndCheck (0.00s)
=== RUN   TestDelAndCheck
--- PASS: TestDelAndCheck (0.00s)
PASS
ok  	isabelle/exported/Interface	0.002s
~~~

The `test/quick/go` folder contains some hand-written wrapper code that
references the generated code in `test/quick/export`. Note that the above
invocation of `go test` will fail if the generated code is not present.

The purpose of the hand-written code is to demonstrate that the generated code
does indeed run as expected.

## Testing the whole thing

Besides the `Go_Test_Quick` test session, there is also a `Go_Test_Slow` test
session, which -- as the name indicates -- takes much longer to execute:

~~~shell
isabelle build -v -e -d . Go_Test_Slow
~~~

Alternatively, you can test the whole thing:

~~~shell
isabelle build -v -e -D .
~~~

If run this for the first time, it may take quite a while to complete (half an
hour on a slow machine).

## Using Docker/Podman

If you do not want to install Isabelle or Go, you can also run the test
session.

Build and run the Docker image as follows:

~~~shell
docker build -t isabelle_go_test .
docker run -it --rm isabelle_go_test
~~~

If you supply a different entry point when starting the container (e.g.
`/bin/bash`), you can also play with the Go target interactively.

The first command (`docker build`) should be fairly quick, but as above,
`docker run` may take quite a while.

In the container, the code will be generated into the folder
`/home/isabelle/go-code-gen/test/quick/export`. By using the following Docker
commands, you can inspect the generated files:

~~~shell
docker run -it --name=generated_go isabelle_go_test
docker cp generated_go:/home/isabelle/go-code-gen/test/quick/export <local_directory>
~~~

This instructs Docker not to delete the temporary container, and then uses
`docker cp` to extract the generated code.
