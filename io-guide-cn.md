# Io 语言入门

## 介绍

### 简介

Io 语言是一门动态的基于原型的语言，语言模型主要参考了 Smalltalk (所有值都是对象), Self(基于原型), NewtonScript(差异化继承), Act1(并发模型), Lisp(运行时可检测和修改代码树)和 Lua(小巧可嵌入性)等语言的特性.

过去三十年, 人们对编程语言的关注，已经转移到了具备强大的表达力的高级语言(比如 Ruby Python Javascript)，以及性能卓越的底层语言(比如 C C++ Java). 结果就是一系列的中间语言(既不如 C 快，又不如 Ruby Javascript 那样有强大的表达力)逐渐成为过去.

Io 语言的目的，就是充分把高级动态语言的特性 -- 运行时动态扩展和简洁的语法发挥出来, 重新把语言的重点放在语言的表达能力上.

在 Io 语言中，所有变量都是对象，所有变量都可以在运行时改变，包括 `槽(slot)`, 方法和其继承关系. 代码是由表达式组成，可以在运行时任意查看和修改; 所有表达式都隐含了一个动态的信息发送，包括赋值结构和控制结构也是一样.

不断变化的上下文本身就是对象，函数, 代码块和命名空间也都是可以动态的赋值并进行传递的对象. 通过 actors 使得语言的并发特性变得更容易实现，并且使用 coroutines 机制让其具备更大的扩展能力.

### 目标

Io 语言被设计成:

#### 简单

- 语言模型简单一致
- 容易嵌入和扩展到别的语言中

#### 灵活

- 完全动态的和运行时的动态修改
- 高度并发的(通过 coroutines 和异步 i/o)

#### 实用

- 足够快
- 跨平台
- 开源的 BSD/MIT 证书
- 完整的函数库

### 下载:

可以直接从这个网站下载已经编译好的可执行文件：

```
http://iobin.suspended-chord.info/
```

也可以到官方网站了解详情：

```
http://iolanguage.com
```

### 从源码安装:

以下测试仅在 Ubuntu 12.04 server 版本上获得通过：

```
sudo apt-get install git-common
git clone https://github.com/stevedekorte/io.git
sudo apt-get install gcc g++ lib2.0 cmake make
cd io
mkdir build
cd build
cmake ..
make install
```

在 Windows 平台上 Mingw/cygwin 环境中均因为 lib2.0 库文件不全而无法编译。

在 macOS 安装（通过brew），打开终端执行

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

安装好brew之后，在终端执行

```
brew install io
```

### 备注

从源码中可以获取语言在各种编辑器上的语法高亮脚本：

源码地址（近期开始活跃）：

```
https://github.com/stevedekorte/io.git
```

各种编辑器的语法高亮目录：

```
io-master\extras\SyntaxHighlighters
```

Vim 高亮文件：

```
https://github.com/andreimaxim/vim-io
```

参考教程：

```
七周七语言第二章
# stackoverflow 上的一些 Io language 的问题
http://stackoverflow.com/questions/tagged/iolanguage
http://www.chrisumbel.com/article/io_language_prototype
http://www.ituring.com.cn/tupubarticle/1664
http://www.bennadel.com/blog/2064-seven-languages-in-seven-weeks-io-day-1.htm
```

### 二进制文件:

Io 会建立两份可执行文件并且把它们替换到二进制文件夹中:

```
io_static
io
```

io_static 可执行文件包括了原始类型支持的最小集合，都是静态链接到它上面的. io 可执行文件则可以加载 iovm 动态链接库，可以在需要的时候动态加载 io 插件.

## 运行 Io 脚本

例子:

```
io samples/misc/HelloWorld.io
```

这种方式下不需要 main 方法或者对象，脚本在编译后就执行了.

## 交互模式

运行:

```
./_build/binaries/io
```

也可以直接输入:

```
io
```

这样就打开了解释器的交互模式.

你可以在交互模式下直接输入代码来执行，比如:

```
Io> "Hello world!" println
==> Hello world!
```

表达式在 Lobby 的上下文中执行:

```
Io> print
[printout of lobby contents]
```

如果你在 `home` 文件夹中有一个 .iorc 文件，它会在解释器模式加载前执行.

## 检查对象

你可以获得一个对象的槽 (slot) 的列表:

```
Io> someObject := Object clone
Io> someObject slotNames
```

如果要排序显示出来:

```
Io> someObject slotNames sort
```

要以漂亮的格式来展示，`slotSummary` 方法很便捷:

```
Io> slotSummary
==>  Object_0x20c4e0:
  Lobby            = Object_0x20c4e0
  Protos           = Object_0x20bff0
  exit             = method(...)
  forward          = method(...)
```

更进一步查看:

```
Io> Protos
==>  Object_0x20bff0:
  Addons           = Object_0x20c6f0
  Core             = Object_0x20c4b0

Io> Protos Addons
==>  Object_0x20c6f0:
  ReadLine         = Object_0x366a10
```

看起来只有 `ReadLine` 在插件里面，没有别的了.

查看一个方法，会打印出没有编译的方法代码：

```
Io> Lobby getSlot("forward")
==> # io/Z_Importer.io:65
method(
    Importer import(call)
)
```

### doFile 和 doString

脚本文件可以在交互模式下使用 doFile 方法直接运行:

```
doFile("scriptName.io")
```

doFile 所在对象的上下文环境是被称为 receiver，在这里就是默认的顶级对象 `Lobby`. 想在别的对象所在的上下文环境中执行脚本的话，可以把 doFile 消息发送给它.

```
someObject doFile("scriptName.io")
```

doString 方法可以用来执行生成一个 string :

```
Io> doString("1+1")
==> 2
```

同样，也可以指定一个上下文:

```
someObject doString("1 + 1")
```

### 命令行参数

打印出命令行参数的示例:

```
System args foreach(k, v, write("'", v, "'\n"))
```

## launchPath

System 的 `launchPath` 槽用来设定初始源文件执行的位置. 当交互模式提示符出现(不显式指定源文件路径)，launchPath 就是当前的工作目录:

```
System launchPath
```

## 语法 Syntax

### 表达式 Expressions

Io 语言没有关键字或者声明语句. 一切都是由表达式组成的消息，每一个都是在运行时可以被访问的对象. 正式的 BNF 表述如下:

```
exp        ::= { message | terminator }
message    ::= symbol [arguments]
arguments  ::= "(" [exp [ { "," exp } ]] ")"
symbol     ::= identifier | number | string
terminator ::= "\n" | ";"
```

考虑到性能的原因，String 和 Number 字面消息会缓存结果在消息对象中.

### 消息 Message

消息的参数以表达式的方式传入，并在 receiver 中执行.

根据参数取值选择逻辑可以用来实现控制流，比如:

```
for(i, 1, 10, i println)
a := if(b == 0, c + 1, d)
```

上面的代码中，for 和 if 都是普通的消息而已，并不是什么关键字.

类似的，动态赋值可以用来实现枚举的功能，而不需要一个封闭的代码块:

```
people select(person, person age < 30)
names := people map(person, person name)
```

像 map, select 之类的方法往往被用于表达式直接过滤值集合:

```
people select(age < 30)
names := people map(name)
```

有一些运算符 (包括赋值) 的语法糖，在编译成消息树以后被 Io 的宏执行:

```
Account := Object clone
Account balance := 0
Account deposit := method(amount,
    balance = balance + amount
)

account := Account clone
account deposit(10.00)
account balance println
```

像 Self 语言一样, Io 的语法并不区分访问的是一个方法还是一个直接量.

### 操作符

操作符只是一个普通的消息，而且这个消息不包含任何字母 (or, and 和 return 除外):

```
1 + 2
```

它会被编译成:

```
1 +(2)
```

如果你需要括号分组:

```
1 +(2 * 4)
```

符合C的优先级顺序:

```
1 + 2 * 3 + 4
```

会被转换为:

```
1 +(2 *(3)) +(4)
```

用户定义的操作符(非标准的操作符名字)是自左向右结合运算的.

### 赋值

Io 有三种赋值运算符:

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

本地对象中，updateSlot 被覆写，如果这个槽不存在，这个槽就会被更新到对象中. 这个操作不需要显式的声明就可以做到.

### 数字

有效的数字格式:

```
123
123.456
0.456
.456
123e-4
123e4
123.456e-7
123.456e2
```

十六进制数亦被支持(不限大小写):

```
0x0
0x0F
0XeE
```

### 字符串

字符串用一组双引号 + 转义符来定义:

```
s := "this is a \"test\".\nThis is only a test."
```

或者，不使用转义字符的话可以写成多行(用三个双引号):

```
s := """this is a "test".
This is only a test."""
```

### 注释

注释支持 //, /**/ 和 # 风格:

```
a := b // add a comment to a line

/* comment out a group
a := 1
b := 2
*/
```

`#` 风格在 Unix 中很有用:

```
#!/usr/local/bin/io
```

就这些！一切都是表达式. 这些就是控制流, 对象, 方法, 异常和其他语法表达式，以及语义.

## 对象

### 概览

通过对概念的统一，Io 的导引描述了简单和强大的原则.

```
concept               unifies
scopable blocks       functions, methods, closures
prototypes            objects, classes, namespaces, locals
messages              operators, calls, assigns, var access
```

### 原型

一切都是对象，包括存储代码块的本地变量和命名空间，而所有对象又都是消息 (包括赋值操作符). 对象可以由一串键值对组成，他们被称为 `槽(slot)`，每一个对象都自内部对象继承而来，被继承的对象被称为 `原型(proto)`. 槽的键可以是一个符号(唯一的无意义序列)，值可以是任意对象类型.

### clone 和 init

新建的对象通过 clone 已有对象来实现. clone 出来的东西其实是一个空对象，但是在它的原型列表中，可以找到它的父对象. 在这个过程后，新建对象的init槽会被调用，以便初始化对象自己. 就像NewtonScript一样，槽在Io中是符合 `创建-写入` 模式的:

```
me := Person clone
```

添加一个实例变量或者方法:

```
myDog name := "rover"
myDog sit := method("I'm sitting\n" print)
```

如果存在 init 方法的话，clone 后 init 会被自动调用.

### 继承

对象收到消息的时候，如果消息符合该对象的某一个槽，就执行，如果找不到，那么就一层一层向上找它的原型. 查找循环会被检测到，它是不被允许的. 如果匹配的槽包含一个可激活的对象，比如Block或者CFunction，它包含任何其他值类型，就会被递归调用. Io命名空间中没有全局变量，根对象被称为Lobby.

因为没有类，只有原型，那么子类和实例本身也就没有任何区别了. 这里有一个创建相同子类的例子:

```
Io> Dog := Object clone
==> Object_0x4a7c0
```

以上代码设置了Lobby的槽 `Dog` 为 Object 对象，这个新对象的原型列表只包含一个对 Object 的引用，本质上指明了这就是Object的子类. 实例变量和方法继承自这个原型列表. 如果设置了这个槽，创建新槽并不会改变它的原型对象:

```
Io> Dog color := "red"
Io> Dog
==> Object_0x4a7c0:
  color := "red"
```

### 多重继承

你可以添加任意数量的原型到对象的原型列表上. 当对象收到一个消息的时候，它会深度搜索原型链寻找匹配.

### 方法

方法就是一种匿名函数，调用的时候，会创建一个对象存储在本地变量集合里面，并且设置这个对象的原型指针和它自己的槽到相应的消息上面. 这个Object的method()方法可以用来创建对象:

```
method((2 + 2) print)
```

对象中使用这个 method 的例子:

```
Dog := Object clone
Dog bark := method("woof!" print)
```

以上代码创建了一个 Object 的子类 `Dog` ，并且添加了 `bark` 槽，这个槽包含了打印 `woof!` 的代码块. 调用示例:

```
Dog bark
```

默认返回值就是最后一行表达式语句的结果.

### 参数

方法定义的时候可以带参数:

```
add := method(a, b, a + b)
```

总的来说，形式如下:

```
method(<arg name 0>, <arg name 1>, ..., <do message>)
```

### 代码块

除去词法的变量范围以外，代码块和方法一样. 变量查找会在代码块创建的上下文中继续，而不是在调用代码块的消息的上下文中继续. 一个代码块可以使用 Object 的 block() 方法来创建:

```
b := block(a, a + b)
```

### 代码块和方法

有时候这两个概念会引起混乱，所以有必要再细细解释一下. 代码块和方法都可以创建在被调用时可以持有本地变量的对象. 不同之处就在于本地对象的 `proto` 和 `self` 槽设置到哪里去. 方法中，这些槽设置到消息对象的目标去，而在代码块中，它们是被设置到代码块创建时的本地对象中去的. 所以一次失败的变量查找，将引起在代码块创建上下文的本地变量中继续查找，而方法则是在消息接收者中继续查找.

### call 和 self 槽

当本地对象被创建，self槽被设置

当本地对象创建，它的self槽和call槽会被设置到Call对象中，以用以获取关于代码块调用的信息:

```
slot               returns
call sender        locals object of caller
call message       message used to call this method/block
call activated     the activated method/block
call slotContext   context in which slot was found
call target        current object
```

### 可变参数

本地变量的 `call message` 槽可以用来获取不定参数消息. 见 if() 的实现:

```
myif := method(
    (call sender doMessage(call message argAt(0))) ifTrue(
    call sender doMessage(call message argAt(1))) ifFalse(
    call sender doMessage(call message argAt(2)))
)

myif(foo == bar, write("true\n"), write("false\n"))
```

doMessage() 方法把参数传入 receiver 的上下文中，一个简洁的写法是使用 evalArgAt():

```
myif := method(
    call evalArgAt(0) ifTrue(
    call evalArgAt(1)) ifFalse(
    call evalArgAt(2))
)

myif(foo == bar, write("true\n"), write("false\n"))
```

### 朝前看 Forward

如果对象不响应消息，而且 forward 方法存在的话，会调用 forward 方法. 这个例子是显示怎样打印查找失败消息的:

```
MyObject forward := method(
    write("sender = ", call sender, "\n")
    write("message name = ", call message name, "\n")
    args := call message argsEvaluatedIn(call sender)
    args foreach(i, v, write("arg", i, " = ", v, "\n") )
)
```

### 重发 resend

以 self 作为上下文，将当前消息发给 receiver 的原型链:

```
A := Object clone
A m := method(write("in A\n"))
B := A clone
B m := method(write("in B\n"); resend)
B m
```

打印:

```
in B
in A
```

重发其他消息给 receiver 的原型时，会使用到 super.

### 超类 Super

如果你需要直接发消息给原型:

```
Dog := Object clone
Dog bark := method(writeln("woof!"))

fido := Dog clone
fido bark := method(
    writeln("ruf!")
    super(bark)
)
```

重发和 super 都在 Io 中实现了.

### 自省

使用以下方法你可以自省 Io 的命名空间. 也有方法用来在运行时修改这些属性值.

#### slotNames

slotNames 方法返回一个对象槽名字的列表:

```
Io> Dog slotNames
==> list("bark")
```

#### protos

protos方法返回对象继承的一个列表:

```
Io> Dog protos
==> list("Object")
```

#### getSlot

getSlot 方法用于获取一个槽的实际值:

```
myMethod := Dog getSlot("bark")
```

前文中，我们设置了本地对象的 myMethod 槽为 bark方法. 你如果需要 myMethod 方法本身，但是又不调用它，你可以通过 getSlot 来获取:

```
otherObject newMethod := getSlot("myMethod")
```

#### 代码 code

方法的参数和表达式是可以自省的. 一个好用的办法的就是 code 方法，返回一个源代码的字符串:

```
Io> method(a, a * 2) code
==> "method(a, a *(2))"
```

### 控制流

true, false 和 nil

true, false 和 nil 都是单例，nil一般用于标识一个未设置值或者丢失了的值.

#### 比较方法

比较方法:

```
==, !=, >=, <=, >, <
```

返回 true 或者 false，compare() 方法用于实现真正的比较，返回 -1, 0 或者 1，分别表示小于, 相等和大于.

#### if, then, else

if() 方法的形式:

```
if(<condition>, <do message>, <else do message>)
```

例子:

```
if(a == 10, "a is 10" print)
```

else 参数是可选的. 如果条件表达式执行为 false 或者 nil，都被视作 false.

执行结果也可以返回:

```
if(y < 10, x := y, x := 0)
```

和如下形式一样:

x := if(y < 10, y, 0)

条件可以这样用:

```
if(y < 10) then(x := y) else(x := 2)
```

支持 elseif():

```
if(y < 10) then(x := y)
elseif(y == 11) then(x := 0) else(x := 2)
```

#### ifTrue, ifFalse

支持 Smalltalk 风格的 ifTrue, ifFalse, ifNil 和 ifNonNil 方法:

```
(y < 10) ifTrue(x := y) ifFalse(x := 2)
```

注意: 条件表达式必须用圆括号括起来.

#### 循环 loop

循环方法支持无限循环:

```
loop("foo" println)
```

#### 重复 repeat

Number 的 repeat 方法可以用于把一个对象的方法重复执行你给定的次数:

```
3 repeat("foo" print)
==> foofoofoo
```

#### 直到 while

形式:

```
while(<condition>, <do message>)

a := 1
while(a < 10,
    a print
    a = a + 1
)
```

#### 从..开始直到..结束 for

形式:

```
for(<counter>, <start>, <end>, <optional step>, <do message>)
```

start 和 end 消息只在循环开始时执行一次:

```
for(a, 0, 10,
    a println
)
```

使用 step:

```
for(x, 0, 10, 3, x println)
```

打印:

```
0
3
6
9
```

要反转这个循环的话，使用负值作为 step:

```
for(a, 10, 0, -1, a println)
```

注: first 值是循环的起始值，last 值是标志环完成时的值，所以 1 到 10 的循环会执行 10 次而 0 到 10 的循环会执行 11 次.

#### break, continue

loop, repeat, while 和 for 都是支持 break 和 continue 的:

```
for(i, 1, 10,
    if(i == 3, continue)
    if(i == 7, break)
    i print
)
```

输出:

```
12456
```

### 返回 return

代码块中执行到任何语句时都可以返回:

```
Io> test := method(123 print; return "abc"; 456 print)
Io> test
123
==> abc
```

break, continue 和 return 都通过存取 stopStatus 这个监控循环和消息的内部值来工作.

### 引入 Importer

Importer 原型实现了 Io 内置的引入机制. 你只需要把你的原型放到它们各自的文件中，文件名以 io 结尾，这个 Importer 在原型第一次被用到的时候会自动引入它们. 默认的搜索路径是当前工作目录，你也可以调用 addSearchPath() 来添加路径.

### 并发 Coroutines

Io 使用 coroutines (协程，这里指用户层面的线程协作) 而不是操作系统抢占式的线程实现方式. 这就减少了潜在的因为本地线程和数千个活跃线程切换引起的消耗(内存, 系统调用, 锁和缓存问题等等).

### Scheduler

Scheduler 对象用来重新开始已经挂起的 coroutines(协程，见上文). 当前的 scheduling 系统使用无优先级的FIFO策略.

### Actors

actor 是一个拥有自己线程的对象(拥有自己的协程)，用于处理异步消息队列. 任何对象可以以异步消息的方式发送出去，你只需要重写 asyncSend() 或者 futureSend() 消息:

```
 // synchronous
result := self foo
 // async, immediately returns a Future
futureResult := self futureSend(foo)
 // async, immediately returns nil
self asyncSend(foo)
```

当对象接收到异步消息的时候，会把消息放到队列里面，如果队列里没有的话，会启动一个协程来处理队列中的消息. 队列消息是顺序处理的(FIFO). Control 可以通过调用 yield 用来挂起当前处理流程，让出资源:

```
obj1 := Object clone
obj1 test := method(for(n, 1, 3, n print; yield))
obj2 := obj1 clone
obj1 asyncSend(test); obj2 asyncSend(test)
while(Scheduler yieldingCoros size > 1, yield)
```

会打印出 112233，以下是一个更真实的例子:

```
HttpServer handleRequest := method(aSocket,
    HttpRequestHandler clone asyncSend(handleRequest(aSocket))
)
```

### Futures

Io 的 future 是透明的，当结果准备好的时候，它们就是结果，如果一个消息被发送给future，就会被挂起等待，直到结果准备好. 透明的 future 很强大，因为它们允许程序员尽可能地减小阻塞，把程序员从繁重的异步管理的细节中解脱出来.

### 自动死锁检测

使用future的一个优点是当等待的时候，它会检测等待是否在等待中会产生死锁，如果会的话就抛出异常.

Futures 和命令行接口

命令行会打印表达式的结果，如果结果是Future的话，直到结果返回再打印:

```
Io> q := method(wait(1))
Io> futureSend(q)
[1-second delay]
==> nil
```

如果不想这样，不返回Future就行:

```
Io> futureSend(q); nil
[no delay]
==> nil
Yield
```

对象的异步消息在执行的时候会自动转让控制权，yield方法只是在要明确让出CPU资源的时候调用.

### Pause 和 Resume

暂停和恢复对象，请参见并发方法部分.

### 异常

#### Raise

在异常的原型中调用raise()，表示异常被抛出了.

```
Exception raise("generic foo exception")
```

#### Try和Catch

要捕获异常，使用Object原型的try()方法. try()会捕获任何异常并返回，如果没有异常就返回nil.

```
e := try(<doMessage>)
```

To catch a particular exception, the Exception catch() method can be used. Example:

```
e := try(
    // ...
)

e catch(Exception,
    writeln(e coroutine backtraceString)
)
```

第一个参数是要捕获的异常类型，catch()返回异常.

### Pass

要重新抛出异常的话，使用 pass 方法. 它可以把异常抛给下一个外部的异常处理器，我们往往在所有的 catch 都无法捕获到所需异常的时候抛出:

```
e := try(
    // ...
)

e catch(Error,
    // ...
) catch(Exception,
    // ...
) pass
```

### 自定义异常

自定义异常类型可以 clone Exception 来实现:

```
MyErrorType := Error clone
```

## 内置对象 Primitives

Primitives 是一组 Io 内建的对象，它们的方法通常使用 C 实现并且存放了一些隐含的数据在内. 举例来说，Number 包含了一个 double 精度的浮点数，并且可以像 C 函数一样计算. 所有的 Io 内置对象都继承自 Object 原型，并且是不可变对象. 也就是说这些方法都是不可变的.

这这篇文档不是想要成为参考手册，只不过是想提供一个所有内置对象的概览，给用户一个入门，提供一个基础认识，要了解详情请参见参考手册.

## 对象 Object

### 问号操作符

有时候想要在某方法存在的情况下调用(避免抛出找不到方法的异常):

```
if(obj getSlot("foo"), obj foo)
```

可以用问号操作符写成这样:

```
obj ? foo
```

### 列表

列表是一个存放引用的数组，支持标准的数组操作和遍历方法.

创建空列表:

```
a := List clone
```

用list()方法创建任意列表:

```
a := list(33, "a")
```

添加元素:

```
a append("b")
==> list(33, "a", "b")
```

获取大小:

```
a size
==> 3
```

根据下标获取元素(从0开始):

```
a at(1)
==> "a"
```

设置元素:

```
a atPut(2, "foo")
==> list(33, "a", "foo", "b")

a atPut(6, "Fred")
==> Exception: index out of bounds
```

删除元素:

```
a remove("foo")
==> list(33, "a", "b")
```

插入:

```
a atInsert(2, "foo")
==> list(33, "a", "foo", "56")
```

### 遍历列表 foreach

foreach, map 和 select 方法可以以三种形式调用:

```
Io> a := list(65, 21, 122)

Io> a foreach(i, v, write(i, ":", v, ", "))
==> 0:65, 1:21, 2:122,
```

第二种形式是略去下标的:

```
Io> a foreach(v, v println)
==> 65
21
122
```

第三种形式:

```
Io> a foreach(println)
==> 65
21
122
```

### map 和 select

map 和 select(有的语言里面叫 filter)方法允许执行任意表达式:

```
Io> numbers := list(1, 2, 3, 4, 5, 6)

Io> numbers select(isOdd)
==> list(1, 3, 5)

Io> numbers select(x, x isOdd)
==> list(1, 3, 5)

Io> numbers select(i, x, x isOdd)
==> list(1, 3, 5)

Io> numbers map(x, x*2)
==> list(2, 4, 6, 8, 10, 12)

Io> numbers map(i, x, x+i)
==> list(1, 3, 5, 7, 9, 11)

Io> numbers map(*3)
==> list(3, 6, 9, 12, 15, 18)
```

map 和 select 方法返回新的列表，如果直接在原有列表上操作，可以使用 selectInPlace() 和 mapInPlace().

### Sequence

不变的 Sequence 被称为 Symbol，而可变的 Sequence 和 Buffer 或者 String 是等价的. Literal strings(被双引号引起来的这种string)就是 Symbols，它们是不能改变的. 但是调用 asMutable 可以生成一个可变的字符串:

```
"abc" size
==> 3
```

检查是否存在子串:

```
"apples" containsSeq("ppl")
==> true
```

获取第N个char(byte):

```
"Kavi" at(1)
==> 97
```

切割:

```
"Kirikuro" slice(0, 2)
==> "Ki"

"Kirikuro" slice(-2)  # NOT: slice(-2, 0)!
==> "ro"

Io> "Kirikuro" slice(0, -2)
# "Kiriku"
```

去空格:

```
"  abc  " asMutable strip
==> "abc"

"  abc  " asMutable lstrip
==> "abc  "

"  abc  " asMutable rstrip
==> "  abc"
```

大小写转换:

```
"Kavi" asUppercase
==> "KAVI"
"Kavi" asLowercase
==> "kavi"
```

切割:

```
"the quick brown fox" split
==> list("the", "quick", "brown", "fox")
```

根据其它字符切割:

```
"a few good men" split("e")
==> list("a f", "w good m", "n")
```

转换成 Number:

```
"13" asNumber
==> 13

"a13" asNumber
==> nil
```

字符串插入:

```
name := "Fred"
==> Fred
"My name is #{name}" interpolate
==> My name is Fred
```

字符串插入会代换 #{} 里面的东西，代码可以包含循环等等，但是最后必须返回一个 String.

### Ranges 范围

一个包含起始和结束，还有怎样从开始执行到结束的指令. 当创建一个很大的序列数据列表的时候会很有用，它可以很容易被转成list，或者使用for()被替换.

#### Range 规范

每个对象都可以用在 Ranges 里面，只要实现 nextInSequence 方法. 这个方法接受一个可选参数，表示跳过(skip)多少个对象，然后返回下一个对象，默认的这个skip值是1:

```
Number nextInSequence := method(skipVal,
    if(skipVal isNil, skipVal = 1)
    self + skipVal
)
```

有了 Number 的这个方法，你就可以使用 Number 的 Range 了:

```
1 to(5) foreach(v, v println)
```

上面代码会打印 1 到 5 ，一个一行.

## 文件 File

几个方法:

openForAppending, openForReading, openForUpdating，删除的话就是 remove 方法:

```
f := File with("foo.txt)
f remove
f openForUpdating
f write("hello world!")
f close
```

### 文件夹 Directory

创建一个文件夹对象:

```
dir := Directory with("/Users/steve/")
```

获取一个文件对象的列表:

```
files := dir files
==> list(File_0x820c40, File_0x820c40, ...)
```

获取文件 + 文件夹列表:

```
items := Directory items
==> list(Directory_0x8446b0, File_0x820c40, ...)

items at(4) name
==> DarkSide-0.0.1 # a directory name
```

建立一个文件夹对象:

```
root := Directory clone setPath("c:/") ==> Directory_0x8637b8

root fileNames
==> list("AUTOEXEC.BAT", "boot.ini", "CONFIG.SYS", …)
```

测试文件是否存在:

```
Directory clone setPath("q:/") exists
==> false
```

获取当前工作目录:

```
Directory currentWorkingDirectory
==> "/cygdrive/c/lang/IoFull-Cygwin-2006-04-20"
```

### Date

创建一个日期实例:

```
d := Date clone
```

设置到当前时间:

```
d now
```

以number方式获取时间:

```
Date now asNumber
==> 1147198509.417114
```

获取时间的每一部分:

```
d := Date now
==> 2006-05-09 21:53:03 EST

d
==> 2006-05-09 21:53:03 EST

d year
==> 2006

d month
==> 5

d day
==> 9

d hour
==> 21

d minute
==> 53

d second
==> 3.747125
```

看执行代码的时间是多少:

```
Date cpuSecondsToRun(100000 repeat(1+1))
==> 0.02
```

### 网络

Io 支持异步连接，但是像读写 socket 的行为是同步的，因为调用 coroutine 是无法预期的，直到 socket 完成这步操作，或者超时出现.

创建一个 URL 对象:

```
url := URL with(http://example.com/)
```

获取一个 URL:

```
data := url fetch
```

文件流:

```
url streamTo(File with("out.txt"))
```

一个简单的 whois 客户端:

```
whois := method(host,
    socket := Socket clone \
        setHostName("rs.internic.net") setPort(43)
    socket connect streamWrite(host, "\n")
    while(socket streamReadNextChunk, nil)
    return socket readBuffer
)
```

最简单的服务端:

```
WebRequest := Object clone do(
    handleSocket := method(aSocket,
        aSocket streamReadNextChunk request := aSocket readBuffer
```

betweenSeq("GET ", " HTTP") f := File with(request) if(f exists, f streamTo(aSocket) , aSocket streamWrite("not found") ) aSocket close ) ) WebServer := Server clone do( setPort(8000) handleSocket := method(aSocket, WebRequest clone asyncSend(handleSocket(aSocket)) ) )

```
WebServer start
```

### XML

使用XML转换器来找到网页的链接:

```
SGML // reference this to load the SGML addon
xml := URL with("http://www.yahoo.com/") fetch asXML
links := xml elementsWithName("a") map(attributes at("href"))
```

### Vector

Vector用在Sequence原语类型上面，定义为:

```
Vector := Sequence clone setItemType("float32")
```

Sequence原语类型支持浮点32位操作的SIMD增强. 当前包含add, subtract, multiple和divide，但是未来会支持更多数学, 逻辑和字符串操作. 小例子:

```
iters := 1000
size := 1024
ops := iters * size

v1 := Vector clone setSize(size) rangeFill
v2 := Vector clone setSize(size) rangeFill

dt := Date secondsToRun(
    iters repeat(v1 *= v2)
)

writeln((ops/(dt*1000000000)) asString(1, 3), " GFLOPS")
```

在2Ghz的Mac笔记本上跑会输出:

```
1.255 GFLOPS
```

相似的C代码(SIMD强化)会输出:

```
0.479 GFLOPS
```

从这个例子看，Io 是要比单纯的 C 快大概三倍.

## Unicode

### Sequences

符号, 字符串和 vectors 都统一到一个 Sequence 原型中，Sequence 是一个包含所有可用的硬件数据类型的数组:

```
uint8, uint16, uint32, uint64
int8, int16, int32, int64
float32, float64
```

### 编码

Sequence 有编码属性:

```
number, ascii, ucs2, ucs4, utf8
```

UCS-2和UCS-4分别是 UTF-16, UTF-32 的等宽字符版本. String 只不过是一个带有文本编码的 Sequence 而已; Symbol (符号)是不可变的 String ; 而Vector则是具备数字编码的 Sequence 罢了.

UTF编码是高位优先存储的.

除了输入输出，所有的字符串都是等宽编码. 这种设计带来了简化实现，代码层面也可以分享vector和string的操作，根据下标快速访问，以及Sequence操作的SIMD支持. 所有Sequence方法会自动做必要的类型转换.

### 源代码

Io 的源文件使用 UTF8 编码，当源文件被读入，符号和字符串被存储时按照最小等宽编码. 例子:

```
Io> "hello" encoding
==> ascii

Io> "π" encoding
==> ucs2

Io> "∞" encoding
==> ucs2
```

来查看内部实现:

```
Io> "π" itemType
==> uint16

Io> "π" itemSize
==> 2
```

转换

Sequence 对象有一组转换方法:

```
asUTF8
asUCS2
asUCS4
```

## 嵌入

### 规约

Io 的实现代码 C 代码是按照面向对象风格来完成的，结构体成了对象，而函数变成了方法. 熟悉这些会帮助你理解那些嵌入式的 API.

### 结构体

成员都是小写字母开头，骆驼命名法:

```
typdef struct
{
    char *firstName;
    char *lastName;
    char *address;
} Person;
```

函数

函数命名以结构体开头，然后用一下划线连接，再加上真正的方法名. 每一个结构体都有一个 new 函数和一个 free 函数:

```
List *List_new(void);
void List_free(List *self);
```

所有除了 new 以外的方法都有一个作为首参的结构 -- self.方法名是符合关键字的格式，也就是说，用下划线串起一组词来描述这个方法:

```
int List_count(List *self); // no argument
void List_add_(List *self, void *item); // one argument
void Dictionary_key_value_(Dictionary *self,
    char *key, char *value);
```

### 文件名

每一个结构体都有它自己的 .h 和 .c 文件. 除去后缀，文件名和结构体名字一致. 文件包含该结构体所有的方法.

### IoState

IoState 可以被认为是 Io 的 `虚拟机` 的实例. 尽管这里 `虚拟机` 并不准确，因为它意味着某种特定的实现类型.

### 多状态

Io是多状态的，这意味着它被设计来支持多种状态实例，而这些实例可以存在在同一个进程中. 这些实例互相独立，不共享内存，所以它们可以被不同操作系统线程访问，尽管同一时间只能访问一个.

#### 创建一个状态

这里有一个创建和变更状态的例子:

```
#include "IoState.h"

int main(int argc, const char *argv[])
{
    IoState *self = IoState_new();
    IoState_init(self);
    IoState_doCString_(self, "writeln(\"hello world!\"");
    IoState_free(self);
    return 0;
}
Values
```

我们可以获取返回值并且查看和打印:

```
IoObject *v = IoState_doCString_(self, someString);
char *name = IoObject_name(v);
printf("return type is a ‘%s', name);
IoObject_print(v);
```

#### 检查值的类型

有一些简便的宏来做快速的类型检查:

```
if (ISNUMBER(v))
{
    printf("result is the number %f", IoNumber_asFloat(v));
}
else if(ISSEQ(v))
{
    printf("result is the string %s", IoSeq_asCString(v));
}
else if(ISLIST(v))
{
    printf("result is a list with %i elements",
        IoList_rawSize(v));
}
```

注: 返回值总是 Io 对象，你可以在 Io/libs/iovm/source 的头文件中找到 C 级别的方法，比如这样的函数: IoList_rawSize().

## 附录 Appendix

### 语法 Grammar

#### 消息 messages

```
expression ::= { message | sctpad }
message    ::= [wcpad] symbol [scpad] [arguments]
arguments  ::= Open [argument [ { Comma argument } ]] Close
argument   ::= [wcpad] expression [wcpad]
```

### 符号 symbols

```
symbol ::= Identifier | number | Operator | quote
Identifier ::= { letter | digit | "_" }
Operator ::= { ":" | "." | "'" | "~" | "!" | "@" | "$" |
"%" | "^" | "&" | "*" | "-" | "+" | "/" | "=" | "{" | "}" |
"[" | "]" | "|" | "\" | "<" | ">" | "?" }
```

### 字符串引起 quotes

```
quote     ::= MonoQuote | TriQuote
MonoQuote ::= """ [ "\"" | not(""")] """
TriQuote  ::= """"" [ not(""""")] """""
```

### 隐含边界 spans

```
Terminator ::= { [separator] ";" | "\n" | "\r" [separator] }
separator  ::= { " " | "\f" | "\t" | "\v" }
whitespace ::= { " " | "\f" | "\r" | "\t" | "\v" | "\n" }
sctpad     ::= { separator | Comment | Terminator }
scpad      ::= { separator | Comment }
wcpad      ::= { whitespace | Comment }
```

### 注释 comments

```
Comment    ::= slashStarComment | slashSlashComment | poundComment
slashStarComment  ::= "/*" [not("*/")] "*/"
slashSlashComment ::= "//" [not("\n")] "\n"
poundComment      ::= "#" [not("\n")] "\n"
```

### 数字 numbers

```
number    ::= HexNumber | Decimal
HexNumber ::= "0" anyCase("x") { [ digit | hexLetter ] }
hexLetter ::= "a" | "b" | "c" | "d" | "e" | "f"
Decimal   ::= digits | "." digits |
digits "." digits ["e" [-] digits]
```

### 字符 characters

```
Comma   ::= ","
Open    ::= "(" | "[" | "{"
Close   ::= ")" | "]" | "}"
letter  ::= "a" ... "z" | "A" ... "Z"
digit   ::= "0" ... "9"
digits  ::= { digit }
```

上面的表达式中的大写字母的单词 lexer 会当成字元 tokens.

### 感谢 Credits

Io is the product of all the talented folks who taken the time and interest to make a contribution. The complete list of contributors is difficult to keep track of, but some of the recent major contributors include; Jonathan Wright, Jeremy Tregunna, Mike Austin, Chris Double, Rich Collins, Oliver Ansaldi, James Burgess, Baptist Heyman, Ken Kerahone, Christian Thater, Brian Mitchell, Zachary Bir and many more. The mailing list archives, repo inventory and release history are probably the best sources for a more complete record of individual contributions.

### 参考 References

```
1. Goldberg, A et al.
Smalltalk-80: The Language and Its Implementation
Addison-Wesley, 1983

2. Ungar, D and Smith,
RB. Self: The Power of Simplicity
OOPSLA, 1987

3. Smith, W.
Class-based NewtonScript Programming
PIE Developers magazine, Jan 1994

4. Lieberman
H. Concurrent Object-Oriented Programming in Act 1
MIT AI Lab, 1987

5. McCarthy, J et al.
LISP I programmer's manual
MIT Press, 1960

6. Ierusalimschy, R, et al.
Lua: an extensible extension language
John Wiley & Sons, 1996
```

### 版权 License

Copyright 2006-2010 Steve Dekorte. All rights reserved.

Redistribution and use of this document with or without modification, are permitted provided that the copies reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

This documentation is provided "as is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall the authors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this documentation, even if advised of the possibility of such damage.

引用自：https://my.oschina.net/u/563463/blog/285060
