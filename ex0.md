# 练习0. 准备工作

工欲善其事，必先利其器，我们要做一点准备工作

## 安装io运行的环境

### 下载：

可以直接从这个网站下载已经编译好的可执行文件：

```
http://iobin.suspended-chord.info/
```

也可以到官方网站了解详情：

```
http://iolanguage.com
```

### 从源码安装：

以下测试仅在 Ubuntu 12.04 server 版本上获得通过：

```
sudo apt-get install git-common
git clone https://github.com/stevedekorte/io.git
sudo apt-get install gcc g++ lib2.0 cmake make
cd io
mkdir build
cd build
cmake ..
make install
```

在 Windows 平台上 Mingw/cygwin 环境中均因为 lib2.0 库文件不全而无法编译。

## 准备一个趁手的文本编辑器

### 下载 visual studio code

Microsoft在2015年4月30日Build 开发者大会上正式宣布了 Visual Studio Code 项目：一个运行于 Mac OS X、Windows和 Linux 之上的，针对于编写现代 Web 和云应用的跨平台源代码编辑器。

https://code.visualstudio.com/

### 给 visual studio code 安装 io 语言支持插件

在插件中心里，搜索 io 或者 iolang-syntax ，安装上

### 给 visual studio code 安装 Code Runner 插件

在插件中心里，搜索Code Runner插件，安装上，在编辑器的配置文件中，增加

```
// Set the executor of each language.
    "code-runner.executorMap": {
        "io": "io"
    },
    "files.associations": {
        "*.io": "io"
    },
```

这样就可以在编辑器里运行io文件了

>   macOS测试可用，其他系统请参考修改

## 运行 io

例子：

```
io samples/misc/HelloWorld.io
```

这种方式下不需要 main 方法或者对象，脚本在编译后就执行了。

### 交互模式

运行：

```
./_build/binaries/io
```

也可以直接输入：

```
io
```

这样就打开了解释器的交互模式。

你可以在交互模式下直接输入代码来执行，比如：

```
Io> "Hello world!" println
==> Hello world!
```

表达式在 Lobby 的上下文中执行：

```
Io> print
[printout of lobby contents]
```

如果你在 `home` 文件夹中有一个 .iorc 文件，它会在解释器模式加载前执行。

