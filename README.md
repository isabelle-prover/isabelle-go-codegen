# Go Code Generation for Isabelle

[![DOI](https://zenodo.org/badge/697269869.svg)](https://zenodo.org/badge/latestdoi/697269869)

This repository contains a standalone Code Generation Target for the Go
programming language for use with Isabelle2023.


## Trying it out

To use it, simply import the `Go` session defined herein into your own development,
and import the `Go_Setup` theory. Code can then be exported in the usual way with

~~~isabelle
export_code <name> in Go
~~~

which produces code that can be used from Go.

### Example: Factorial with raw Isabelle nats

The following example implements the factorial function and exports it to Golang.

~~~isabelle
theory Scratch
  imports "git/isabelle-go-codegen/Go_Setup" (*the path to this repo*)
begin

fun factorial :: "nat \<Rightarrow> nat" where
  "factorial 0 =  1" |
  "factorial (Suc n) = (Suc n) * (factorial n)"

export_code factorial in Go module_name main

end
~~~

The file needs to be saved as `Scratch.thy`.

Since there is no Golang-specific tuning for nats,
the Isabelle type for nats will be serialized without any optimization.
This creates the following code:

~~~golang
package main

import (
)

// sum type which can be Zero_nat, Suc
type Nat any;
type Zero_nat struct { };
type Suc struct { A Nat; };

func Suc_dest(p Suc)(Nat) {
  return p.A
}

func Plus_nat (x0 Nat, n Nat) Nat {
  {
    q, m := x0.(Suc);
    if m {
      ma := Suc_dest(q);
      nb := n;
      return Plus_nat(ma, Nat(Suc{nb}));
    }
  };
  {
    if x0 == (Nat(Zero_nat{})) {
      nb := n;
      return nb;
    }
  };
  panic("match failed");
}

func Times_nat (x0 Nat, n Nat) Nat {
  {
    if x0 == (Nat(Zero_nat{})) {
      return Nat(Zero_nat{});
    }
  };
  {
    q, m := x0.(Suc);
    if m {
      ma := Suc_dest(q);
      nb := n;
      return Plus_nat(nb, Times_nat(ma, nb));
    }
  };
  panic("match failed");
}

func One_nat () Nat {
  return Nat(Suc{Nat(Zero_nat{})});
}

func Factorial (x0 Nat) Nat {
  {
    if x0 == (Nat(Zero_nat{})) {
      return One_nat();
    }
  };
  {
    q, m := x0.(Suc);
    if m {
      na := Suc_dest(q);
      return Times_nat(Nat(Suc{na}), Factorial(na));
    }
  };
  panic("match failed");
}
~~~

The generated code can be called as follows:

~~~golang
func main() {
	n6 := Suc{Suc{Suc{Suc{Suc{Suc{Zero_nat{}}}}}}}
	n720 := Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Suc{Zero_nat{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
	fmt.Printf("Factorial(6) == 720: %v\n", Factorial(n6) == n720)
}
~~~

[Run on Go Playground](https://go.dev/play/p/miUqwfOVdCf).

## Running a small Red Black Tree test suite

This repository contains a test session `Go_Test`. If you have Isabelle2023
installed, just run the following command:

~~~shell
isabelle build -v -e -D .
~~~

This will build the `Go_Test` session and export some sample code to
`go_test/export`. If run for the first time, this may take quite a
while to complete (half an hour on a slow machine).

To test the generated code, run the following commands:

~~~shell
cd go_test/go
go test -v ./Interface
~~~

This should produce some (successful) test output, indicated with `PASS`.

The `go_test/go` folder contains some hand-written wrapper code that references
the generated code in `go_test/export`. Note that the above invocation of
`go test` will fail if the generated code is not present.

The purpose of the hand-written code is to demonstrate that the generated code
does indeed run as expected.

## Using Docker/Podman

If you do not want to install Isabelle or Go, you can also run the test
session.

Build and run the Docker image as follows:

~~~shell
docker build -t isabelle_go_test
docker run -it --rm isabelle_go_test
~~~

If you supply a different entry point when starting the container (e.g.
`/bin/bash`), you can also play with the Go target interactively.

Again, the `docker build` may take quite a while, but `docker run`
should complete within a few minutes.

In the container, the code will be generated into the folder
`/home/isabelle/go-code-gen/go_test/export`. By using the following Docker
commands, you can inspect the generated files:

~~~shell
docker run -it --name=generated_go isabelle_go_test
docker cp generated_go:/home/isabelle/go-code-gen/go_test/export <local_directory>
~~~

This instructs Docker not to delete the temporary container, and then uses
`docker cp` to extract the generated code.
