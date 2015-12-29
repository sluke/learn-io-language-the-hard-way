f := File with("readme.txt")
	
f remove // 移除原内容

f openForUpdating // 以updating的方式打开
c := """你好，我来写入一些中文
还有 English
这是第三行
""" asUTF8 //改变中文编码，以便正常写入及显示
f write(c)
f close //关闭文件

"\n****循环读取****\n" println
f openForReading
f foreachLine(i, v, writeln("Line ", i, ": ", v))
f close 

"\n****从第一行读起，每次一行****\n" println
f openForReading
f readLine println // 每次只读一行
f readLine println
f close 

"\n****只输出第二行****\n" println
f openForReading
s := List clone
s := f readLines // 直接 f at(1) 会返回 byte
s at(1) println
f close

"\n****读取全部内容****\n" println
f contents println // 读取内容
