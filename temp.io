Dog := Object clone
Dog dark := method(writeln("woof!"))
	
fido := Dog clone
fido dark := method(
	writeln("ruf!")
	super(dark)
)
fido dark

fido slotNames println
#fido getSlot("dark") println
