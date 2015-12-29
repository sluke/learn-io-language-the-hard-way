# 复制内容到另一个文件

f := File with("readme.txt")
cp := File with("cp.txt") create // 创建一个空文件

cp openForUpdating
cp write(f contents)
"copy done" println
cp close
