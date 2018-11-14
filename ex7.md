# 练习7. 还是赋值、拼接和打印

多做一点练习总是没有错的，略微做一点修改，帮助我们理解`print`和`println`

- `print`，打印，不换行
- `println`，打印，换行

```
"Mary had a little lamb." println

a := "sonw"
("Its fleece was white as" .. a )println

"And everywhere that Mary went." println

// 重复10次
10 repeat("*" print)
"\n" print //空一行

/* 拼接 */
end1 := "C"
end2 := "h"
end3 := "e"
end4 := "e"
end5 := "s"
end6 := "e"
end7 := "B"
end8 := "u"
end9 := "r"
end10 := "g"
end11 := "e"
end12 := "r"

(end1 .. end2 .. end3 .. end4 .. end5 .. end6 ..
 end7 .. end8 .. end9 .. end10 .. end11 .. end12) println
```

如果学习程序语言总是需要输入如此多的内容，那就太乏味了，所以这里增加一个看起来智能一点的东西，帮助我们输入 10 个星号。

```
// 重复10次
10 repeat("*" print)
"\n" print //空一行
```

## 你应该看到的结果

```
> io ex7.io
Mary had a little lamb.
Its fleece was white assonw
And everywhere that Mary went.
**********
CheeseBurger
```

