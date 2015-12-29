# List

l := List clone

l := list(0, 1, 2, 3, 4, 5)

l println

l at(1) println

a := l append(6) println
l println
a := l remove(6) println
"\n" print
b := l select(>0.5) println
b := l map(>0.5) println
b := l select(isOdd) println
b := l map(isOdd) println
b := l select(i, x, x isOdd) println
b := l map(i, x, x isOdd) println
b := l map(*2) println
l println
"\n" print
c := l atPut(0, -1) println
c := l atPut(0, 0) println
c := l atInsert(6, 6) println
c := l atInsert(7, "hello wolrd") println
c := l remove("hello wolrd") println
"\n" print	
d := l foreach(print)
"\n" print
d := l foreach(v, (v .. " ") print)
"\n" print
d := l foreach(i, v, write(i, ":", v, ","))