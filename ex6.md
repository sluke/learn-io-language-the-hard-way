# 练习6. 字符串和文本

虽然你已经在程序中写过字符串了，你还没学过它们的用处。在这节练习中我们将使用复杂的字符串来建立一系列的变量，从中你将学到它们的用途。首先我们解释一下字符串是什么。

字符串通常是指你想要展示给别人的，或者是你想要从程序里“导出”的一小段字符。io 可以通过文本里的双引号`"`识别出字符串来。这在你以前的 print 练习中你已经见过很多次了。如果你把双引号括起来的文本放到 print 前面，它们就会被 io 打印出来。

下面会有一些特殊的用法，也会很好理解，坚持一下。

```
s := "this is a \"test\".\nThis is only a test."
x := "\""
y := "\\"

c := """this is a "test".
This is only a test."""

ChineseContent :=""" 
就是写点中文试试，
换一行

换好几行



结束换行
"""

a := "啊\t"
b := "世界\n你好"
shadow := "我叫做shadow，但是大家应该在结果中看不到我，因为我没有被打印出来"

s println
x println
y println
c println
ChineseContent println
(a .. b) println
```

在io语言，或者说绝大部分编程语言的世界里，有些字符是有特殊用途的，比如 `=`、`"`、`\`、`//` 等等，如果需要把这些特殊符号打印出来，就可以使用反斜杠 \\(back-slash)，就像下面这一句的用法

```
s := "this is a \"test\".\nThis is only a test."
```

还可以用三个引号的方式，也就是`"""`，就像下面这一句

```
c := """this is a "test".
This is only a test."""
```

三个引号的用法，可以用来保持输入的原始格式

```
ChineseContent :=""" 
就是写点中文试试，
换一行

换好几行



结束换行
"""
```

在下面的两行中，用到了 `\t`和`\n`，`\t`是制表符，效果相当于一个`tab`，`\n`是换行符，效果相当于回车

```
a := "啊\t"
b := "世界\n你好"
```

在程序的最后，有一些东西与前面的练习都不同

```
s println
x println
y println
c println
ChineseContent println
(a .. b) println
```

在整段程序里，我们创造了一些叫做`s`、`x`、`y`、`a`、`b`、`c`的容器，然后分别装进去不同的字符串，只是这样还不够，它们还不能被看见，末尾这几句的意思，就是把容器里的内容都打印出来，否则我们看不到它们。实际上，这里包含了io语言中最普遍的范式，那就是：

-   创造一些容器
-   把一些东西装到容器里
-   让容器里的内容被感知到

## 你应该会看到

```
> io ex6.io
this is a "test".
This is only a test.
"
\
this is a "test".
This is only a test.
 
就是写点中文试试，
换一行

换好几行



结束换行

呵呵	世界
你好
```