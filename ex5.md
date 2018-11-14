# 练习5. 更多的变量和打印

我们现在要输入更多的变量并且把它们打印出来。练习4里面有些做法还是很啰嗦的，这里我们做一点改进。

```
Cars := 100
SpaceInACar := 4
Drivers := 30
Passengers := 90
CarsNotDriven := Cars - Drivers
CarsDriven := Drivers
CarpoolCapacity := CarsDriven * SpaceInACar
AveragePassengersPerCar := Passengers / CarsDriven

// 与练习4中不同的用法
s := ("There are " .. Cars .. " cars available.") println

// 另一种与练习4中不同的用法
("There are only " .. Drivers .. " drives available.") println

// 后面的都用与练习4相同的方法
"There will be " print .. CarsNotDriven print .. " empty cars today." println
"We can transport " print .. CarpoolCapacity print .. " people today." println
"We have " print .. Passengers print .. " to carpool today." println
"We need to put about " print .. AveragePassengersPerCar print .. " in each car." println

// 更新一下
Cars = 80
"Update ! There are " print .. Cars print " cars available" println
```

有 2 处用法与练习4不同，都省略掉了几个 `print`


## 你应该看到的结果

```
> io ex5.io
There are 100 cars available.
There are only 30 drives available.
There will be 70 empty cars today.
We can transport 120 people today.
We have 90 to carpool today.
We need to put about 3 in each car.
Update ! There are 80 cars available
```
结果与练习4并没有什么区别