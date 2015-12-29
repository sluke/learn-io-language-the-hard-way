# 对象、原型、方法

# 对象
Dog := Object clone
Dog name := "Hello" // 属性
Dog sit := method("I'm sitting\n" print) // 对象的方法

Dog name println
Dog sit
Dog slotSummary println

write("\n")
# 对象另一种方式
Person := Object clone do(
	name := "Person"
	walk := method("I'm walking\n" print)
)

Person name println
Person walk
Person slotSummary println

write("\n")
# 继承
Jack := Person clone
Jack walk
Jack walk := method("I'm walking and laughing\n" print) // 重新定义方法
Jack walk
Jack protos println
Jack slotSummary println

write("\n")
# 增加对象的方法？不是
Happy := Dog clone
Happy name := "Happy"
Happy name println
Happy sit
Happy walk := Jack walk // 这里只是调用了Jack的walk方法的结果
Happy walk
Happy slotSummary println