# 循环

3 repeat("重要的事情说三遍" println)
	
writeln

# while

a := 0
while(
	a<10,
	(a .. " ") print
	a = a+1
)

"\n" println

# for

for(i, 0, 10, 4,
	"for (变量, 初始值, 结束值, 步长, 操作)" println
) //重要的事情说三遍

writeln

# break

for(i, 1, 9,
	if(i == 2, continue)
	if(i == 7, break)
	i println
)
