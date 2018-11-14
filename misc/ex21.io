# 操作文本

f := File with("readme.txt")
f openForReading
f contents println

"----以上是原文本----" println
("f的编码 " .. (f contents encoding)) println
("f的字符长度 " .. (f size)) println

c := f contents
("是否包含有\“English\”? " .. c containsSeq("English")) println
("是否包含有\“哈哈\”? " .. c containsSeq("哈哈")) println
("是否包含有\“你好\”? " .. c containsSeq("你好")) println	// 出错了吧
# 做一点修改，用utf8来查找
c := f contents asUTF8
("c的编码 " .. c encoding) println
s := "你好" asUTF8
("s的编码 " .. s encoding) println
("是否包含有\“你好\”? " .. c containsSeq(s)) println	
