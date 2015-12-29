Dog := Object clone do(
	bark := method("woof!" println)
	light := method("sleep!" println)
)

Dog bark
Dog light
Dog type println

Dog slotNames println

Dog getSlot("bark") println
write ("\n")

a := list clone
a := list(33, "a", "b", "ui")
write ("\n")

a foreach(i, v, writeln(i, ":", v, ","))

write ("\n")
num := a size
a for(i, 0, num-1, 2, 
	write(i, ":", a at(i), ", \n")
)
write ("\n")
"nihaodfj" exSlice(-2) println

write ("\n")
	
/*
digest := MD5 clone
digest appendSeq("this is a message")
out := digest md5String println
write ("\n")
RandomNum := Random clone
RandomNum bytes(1) println
RandomNum value(3, 4) println
RandomNum setSeed(33)
write ("\n")
testReturn := method(
	123 println;
	return "abc";
	456 println;
)
testReturn
*/
for(i, 1, 10,
	if(i == 3, continue)
	if(i == 7, break)
	i println
)
write ("\n")

for(i, 0, 5,
	k := 2*i-1
	j := 5-i
	j repeat(" " print);k repeat("*" print);
	write("\n")
)
for(i, 4, 0, -1,
	k := 2*i-1
	j := 5-i
	j repeat(" " print);k repeat("*" print);
	write("\n")
)


A := Object clone
A m := method(write("in A\n"))
B := A clone
B m := method(write("in B\n"); resend)
B m