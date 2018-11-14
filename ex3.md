# 练习3. 数字和数学计算

每一种编程语言都包含处理数字和进行数学计算的方法。不必担心，程序员经常撒谎说他们是多么牛的数学天才，其实他们根本不是。如果他们真是数学天才，他们早就去从事数学相关的行业了，而不是写写广告程序和社交网络游戏。

这节练习里有很多的数学运算符号。我们来看一遍它们都叫什么名字。你要一边写一边念出它们的名字来，直到你念烦了为止。名字如下：

> - \+ plus 加号
> - \- minus 减号
> -  / slash 斜杠 除法
> - \* asterisk 星号 乘法
> - % percent 百分号 模除
> - < less-than 小于号
> - \> greater-than 大于号
> - \<= less-than-equal 小于等于号
> - \>= greater-than-equal 大于等于号

有没有注意到以上只是些符号，没有运算操作呢？写完下面的练习代码后，再回到上面的列表，写出每个符号的作用。例如+是用来做加法运算的，..是用来连接两个不同的对象。

```
"I will now count my chickens:" println

"Hens " print .. (25 + 30 / 6) println
"Roosters " print .. (100 - 25 * 3 % 4) println

"Now I will count the eggs:" println

(3 + 2 + 1 - 5 + 4 % 2 - 1 + 6) println

"Is it true that 3 + 2 < 5 - 7?" println

(3 + 2 < 5 - 7) println

"What is 3 + 2? " print .. (3 + 2) println
"What is 5 - 7? " print .. (5 - 7) println

"Oh, that's why it's False." println

"How about some more." println

"Is it greater? " print .. (5 > -2) println
"Is it greater or equal? " print .. (5 >= -2) println
"Is it less or equal? " print .. (5 <= -2) println

```

## 你看到的结果

```
> io ex3.io
I will now count my chickens:
Hens 30
Roosters 97
Now I will count the eggs:
6
Is it true that 3 + 2 < 5 - 7?
false
What is 3 + 2? 5
What is 5 - 7? -2
Oh, that's why it's False.
How about some more.
Is it greater? true
Is it greater or equal? true
Is it less or equal? false
```

## 有效的数字格式:

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

## 十六进制数也支持(不限大小写):

```
0x0
0x0F
0XeE
```

