# iolanguage 实现的一个简单weblog系统

### 说明

- 读取指定目录中的 markdown 文件，生成首页的 html 文件
- 读取指定 markdown 文件，生成 html 文件
- 生成指定目录中所有 markdown 文件对应的 html 文件

### 命令帮助
- Index writeIndexHtml // 生成首页
- Index writeAllArticleHtml // 生成所有文章页面
- Article writeArticleHtml("about.md") // 生成单篇文章，参数为 markdown 文件名

### Markdown js

- https://github.com/markedjs/marked

### 中文排版

- https://github.com/iceway/typohan.css

### 目录作用

- md，保存 mmarkdown 文件的目录
- html，保存 html 文件的目录 
