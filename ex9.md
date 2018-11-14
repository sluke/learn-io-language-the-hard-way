# 练习9. io语言的基本概念-都是对象

在练习8里，我们聊到io是基于原型语言，是面向对象编程的一种，在io语言的世界里，一切都是对象，都是容器，甚至可以把io语言自己，也理解为一个容器，它的原型就是它自己。

我们创建一个叫做 object.io的文件，在里面就一句：

```
println
```

## 运行之后，你应该会看到

```
> io object.io
 Object_0x7f9a0c506d00:
  Lobby            = Object_0x7f9a0c506d00
  Protos           = Object_0x7f9a0c506c20
  _                = nil
  exit             = method(...)
  forward          = method(...)
  set_             = method(...)
```

Lobby是io这个小宇宙的名字，叫做`namespace`，命名空间，我们打印出来的，就是一个叫做Lobby的容器里所有的东西，如果在object.io里，只有一句：

```
Lobby println
```

## 运行之后看到的结果也是一样的

```
> io object.io
 Object_0x7f9a0c506d00:
  Lobby            = Object_0x7f9a0c506d00
  Protos           = Object_0x7f9a0c506c20
  _                = nil
  exit             = method(...)
  forward          = method(...)
  set_             = method(...)
```

怎么证明Lobby也是一个对象呢？我们用到`type`这个方法，在object.io里写上

```
Lobby type println
```

运行之后的结果应该是这样

```
> io object.io
Object
```

还可以用 `type` 看看其他的东西都是什么类型

```
Lobby type println
88888 type println
"hello world" type println
true type println
Number type println
```

## 运行之后的结果应该是

```
> io object.io
Object
Number
Sequence
true
Number
```

说明很多类型的 type 就是它自己，也就是顶级对象，类似的还有 Range、Vector、 nil、 System、 List、 Block、 Map、 Return Object、 Path、 File、 WeakLink、 Message、...

练习8和练习9，没有学习过编程语言的人，读起来可能会有点晦涩，下一个练习，我们实战一下。

