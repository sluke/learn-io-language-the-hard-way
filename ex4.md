# 练习4. 变量

你已经学会了使用print语句和算术运算。下一步你要学的是“变量”。在编程中，变量只不过是用来指代某个东西的名字。程序员通过使用变量名可以让他们的程序读起来更像英语。而且因为程序员的记性都不怎么地，变量名可以让他们更容易记住程序的内容。如果他们没有在写程序时使用好的变量名，在下一次读到原来写的代码时他们会大为头疼的。

如果你被这节习题难住了的话，记得我之前教过的：找到不同点、注意细节。

> 给每一行代码加上注释，给自己解释一下这一行的作用。
> 倒着读你的.io文件。
> 朗读你的.io文件，将每个字符朗读出来。

```
Cars := 100
Drivers := 30

"There are " print .. Cars print .. " cars available." println
"There are only " print .. Drivers print .. " drives available." println

Cars = 80
"Update ! There are " print .. Cars print " cars available." println
```

这里用到了io语言中的 **赋值** 概念，io 有三种赋值运算符：

```
operator  action
::=   Creates slot, creates setter, assigns value
:=    Creates slot, assigns value
=     Assigns value to slot if it exists, otherwise raises exception
```

赋值运算符也是普通消息，它们的方法都可以被覆写:

```
source     compiles to
a ::= 1    newSlot("a", 1)
a := 1     setSlot("a", 1)
a = 1      updateSlot("a", 1)
```

是不是略微有点复杂？没关系，可以理解为我们在计算机的世界里创造一个叫做 Cars 的东西，也就是变量，然后给了 Cars 一个值，就是 100，用到了

```
Cars := 100 
```
这个 Cars 是以前不存在，需要凭空创造出来的，所以用到了  `:=`

这个时候，Cars 就已经存在了，我们可以更新它的值，用到了 `=`

```
Cars = 80
```

至于第三种赋值的方式，不理解也没关系，完全不影响后面的学习

```
Cars ::= 100
```
意思是创造一个以前不存在叫做 Cars 的容器，并且给它的一个 `slot` 赋值 100 ，再赋予一个setter方法
> `slot` 对与io语言来说是个非常重要的概念，后面会讲，这里就理解成 Cars 容器里的一个小空间好了

## 你应该看到的结果

```
> io ex4.io
There are 100 cars available.
There are only 30 drives available.
Update ! There are 80 cars available.
```