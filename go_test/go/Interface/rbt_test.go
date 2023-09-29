package rbt

import (
  "testing"
  "isabelle/exported/Bigint"
)

func TestSimple (t* testing.T) {
	array := [5]Bigint.Int{Bigint.MkInt("1"), Bigint.MkInt("2"), Bigint.MkInt("3"), Bigint.MkInt("4"), Bigint.MkInt("5")}
	elements := MkList(array[:])

	t1, ok := TreeFromList(EqualInt, LinorderInt, elements)
	if !ok {
		t.Fatal("new tree does not satisfy invariant")
	}
	_, ok = JoinAndCheck(LinorderInt, t1, t1);
	if !ok {
		t.Fatal("joining trees violated invariant")
	}
	t2, ok := DelAndCheck(EqualInt, LinorderInt, elements, t1)
	if !ok {
		t.Fatal("deletion violated invariant")
	}
	ok = TreesEqual(EqualInt, t2, EmptyTree[Bigint.Int]())
	if !ok {
		t.Fatal("tree not empty after deletion")
	}
}
