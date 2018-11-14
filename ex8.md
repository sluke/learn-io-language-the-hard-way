# 练习8. io语言的基本概念-原型

通过前面的7个练习中，我们大概了解了一个编程语言的最基础部分，练习8要说一些io的基本概念，这部分很有趣，是io语言与众不同的原因。

## 基于原型的io语言

维基百科里，有这样一段定义，尝试理解一下：

> 基于原型的编程（英语：prototype-based programming）或称为原型程序设计、原型编程，是面向对象编程的子系统和一种方式。在原型编程中，类不是实时的，而且行为重用（通常认为继承自基于类的语言）是通过复制已经存在的原型对象的过程实现的。这个模型一般被认为是 classless、面向原型、或者是基于实例的编程。

io语言就是一个基于原型的小众编程语言，吸取了很多其他语言的特点，是不是很厉害：

>   -  [Smalltalk](https://zh.wikipedia.org/wiki/Smalltalk)——所有的变量均为对象、所有的消息都是动态的；
>   -   [Self](https://zh.wikipedia.org/wiki/Self)——基于原型的面向对象设计
>   -   [NewtonScript](https://zh.wikipedia.org/wiki/NewtonScript)——差异化继承
>   -   [Act1](https://zh.wikipedia.org/w/index.php?title=Act1&action=edit&redlink=1)——并发行为和特征
>   -   [LISP](https://zh.wikipedia.org/wiki/LISP)——code is a runtime inspectable/modifiable tree
>   -   [Lua](https://zh.wikipedia.org/wiki/Lua)——小巧且具有可嵌入能力

io语言还有一个鼎鼎大名的同类，JavaScript，如果你学习过它，应该更容易理解io在做什么。

## 怎么通俗理解基于原型编程

实际上，基于原型编程挺符合人类的基本思维模式的，用一个例子你就能理解，乔布斯向世间展示了叫做iPhone的手机，它如此成功，以至于我们在评价后来的手机时，都是这么说的：

> 它有iPhone一样的全触屏
> 它有iPhone一样的双摄像头
> 它有iPhone一样的金属边框
> ……

iPhone，成为了其他手机的`原型`，当我们要设计一个新手机的时候，最简单的方式是克隆一个iPhone，修改其中部分内容。在io语言里，是这样来做的：

还记得我们在练习6里所提到的io语言范式吗？复习一下

> -   创造一些容器
> -   把一些东西装到容器里
> -   让容器里的内容被感知到

让我们来创造一个iPhone

```
iPhone := Object clone
    iPhone name := "iPhoneXS Max"
    iPhone screen := 6.5 // inch
    iPhone cpu := "A12"
    iPhone rom := "4GB"
    iPhone os := "iOS"

iPhone print
```
iPhone是一个物体，在io的世界中，我们叫做一个`对象`

把上面的代码，保存成一个io语言，叫做iPhone.io，执行一下，让我们看看得到了什么

```
> io iPhone.io
 Object_0x7fabb0d76e16:
  cpu              = "A12"
  name             = "iPhoneXS Max"
  os               = "iOS"
  rom              = "4GB"
  screen           = 6.5
```
Object_0x7fabb0d76e16，就是我们无中生有创造的对象，也就是容器，0x7fabb0d76e16是为了跟其他对象区别，自动给的唯一标记。这个容器里什么都没有，还需要放进去一些东西，比如cpu、屏幕、操作系统等等，容器里存放这些东西的地方，就是 `slot` ，我们把slot叫做槽。槽里还是什么都没有，只有不同的名称，于是我们给slot赋值，也就是给容器里不同名称的小格子放进去不同的内容。在这个例子里，就是把`iOS`这个值，放进了iPhone这个容器的里叫做`os`的小格子里。

好了，一个iPhoneXS Max做好了，接下来就是见证奇迹的时刻，先克隆一个iPhone，在iPhone.io里增加

```
iPhone := Object clone
    iPhone name := "iPhoneXS Max"
    iPhone screen := 6.5 // inch
    iPhone cpu := "A12"
    iPhone rom := "4GB"
    iPhone os := "iOS"

iPhone print

newPhone := iPhone clone
```

只需要一句，新手机跟iPhone一模一样，我们用iPhone作为原型，得到了一个新手机。新手机总不能没特点吧，于是我们更新一下小格子里的东西，不是用`:=` ，而是`=`，因为在克隆iPhone的时候，这些`slot`小格子我们也克隆啦，它们是存在的。

```
iPhone := Object clone
    iPhone name := "iPhoneXS Max"
    iPhone screen := 6.5 // inch
    iPhone cpu := "A12"
    iPhone rom := "4GB"
    iPhone os := "iOS"

iPhone print

newPhone := iPhone clone
    newPhone name = "newPhone one"
    newPhone screen = 6 //inch
    newPhone cpu = "Qualcomm"
    newPhone os = "Android"

newPhone println
```

运行一下iPhone.io，你应该看到

```
> io iPhone.io
Object_0x7fabb0d76e16:
  cpu              = "A12"
  name             = "iPhoneXS Max"
  os               = "iOS"
  rom              = "4GB"
  screen           = 6.5

 Object_0x7f908beabd28:
  cpu              = "Qualcomm"
  name             = "newPhone one"
  os               = "Android"
  screen           = 6
```

咦？出问题了，新手机为什么没有内存呢？别着急，新手机是克隆了iPhone，它的内存在没有被修改的情况下，应该是跟原型一致的，增加一句，看看新手机的rom小格子里，放着什么

```
newPhone rom println
```

再运行一下 iPhone.io ，你应该看到

```
> io iPhone.io
 Object_0x7f908be8c530:
  cpu              = "A12"
  name             = "iPhoneXS Max"
  os               = "iOS"
  rom              = "4GB"
  screen           = 6.5

 Object_0x7f908beabd20:
  cpu              = "Qualcomm"
  name             = "newPhone one"
  os               = "Android"
  screen           = 6

4GB
```

newPhone是克隆出来的对象，是一个新的容器，当我们改动新容器里小格子的存放物，甚至是增加新的小格子时，作为原型的iPhone容器并不会有变化。

学习下来是不是有点累？下一个练习我们聊聊怎么理解io语言自己这个容器，休息一下。

