# 读取目录文件
//System launchPath println
dir := Directory with("../ex/")
files := dir fileNames
files remove(".DS_Store")
files foreach(println)