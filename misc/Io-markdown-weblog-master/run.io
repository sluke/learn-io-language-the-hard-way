/* 读取目录下文件
*/

// 配置
mdDir := "md" // md 文件目录
htmlDir := "html" // html 文件目录

webSiteTitle := "一只小网站" asUTF8 // 网站名称
webSiteDescription := "io语言可以做很多事情" asUTF8 // 网站描述

// 获取 Markdown 文件列表
d := Directory clone setPath(mdDir)
mdFileList := List clone
mdFileList = d fileNames remove(".DS_Store")

/* 单篇文章原型
*/
Article := Object clone do(
    // 获取文章元数据
    getMateData := method(
        mdFileName,
        mdFilePath := mdDir .. "/" .. mdFileName

        f := File openForReading(mdFilePath)
        articleTitle := f rewind readLine strip("# ") // 标题，无 markdown 格式
        articlePublicDate := f readLine strip("_*") // 发布日期，无 markdown 格式
        articleMainText := f readToEnd // 正文
        articleFullContent := f contents // 全部内容
        f close

        articleMateData := list(
            articlePublicDate,
            articleTitle,
            mdFileName,
            articleFullContent
        )
    )
    // 生成单篇文章HTML
    writeArticleHtml := method(
        mdFileName,
        
        articleHtmlHeader := ("<!doctype html>
<html>
<head>
    <meta charset=\"utf-8\"/>
    <title>" .. 
    Article getMateData(mdFileName) at(1) .. 
    "</title>\n<script src=\"https://cdn.jsdelivr.net/npm/marked/marked.min.js\"></script>\n<link rel=\"stylesheet\" href=\"style.css\">
</head>") asUTF8

        articleHtmlBoby := """
<body>
    <div id="content"></div>
    <div id="md_contents" style="display:none">
""" asUTF8
        articleHtmlFooter := """
    </div>
  <script>
      var text = document.getElementById('md_contents').innerHTML;
      document.getElementById('content').innerHTML =
        marked(text);
  </script>
  <div><a href="./index.html">回到首页</div>
</body>
</html>
""" asUTF8
        articleHtmlPath := (htmlDir .. "/" .. mdFileName asMutable replaceSeq(".md", ".html"))
        articleHtml := File with(articleHtmlPath)
        articleHtml remove
        articleHtml openForUpdating
        articleHtml write(articleHtmlHeader, articleHtmlBoby, Article getMateData(mdFileName) at(3) ,articleHtmlFooter)
        articleHtml close
        msg := ("\# " .. articleHtmlPath .. " done!") asUTF8 println
    )
)

/* 索引文件原型 
*/
Index := Object clone do(
    // 生成文章索引，并按照发布日期排序
    getArticleList := method(
        articleIndex := List clone
        mdFileList foreach(
            v, articleIndex append(Article getMateData(v))
        ) sortInPlaceBy (
            block(a, b, a > b)
        ) 
    )
    // 文章列表的html
    articleListHtml := method(
        i := 0
        htmlCode := Sequence clone
        while(
            i < Index getArticleList size,
            li := ("\n<li><a href=\"" .. 
                Index getArticleList at(i) at(2) asMutable replaceSeq(".md", ".html") .. 
                "\" title=\"".. 
                Index getArticleList at(i) at(1) .."\">[ " .. 
                Index getArticleList at(i) at(0) .. 
                " ] " .. 
                Index getArticleList at(i) at(1) .. 
                "</a></li>\n") asUTF8
            htmlCode = htmlCode .. li
            i = i + 1
        ) return htmlCode
    )
    // 生成首页html
    writeIndexHtml := method(
        indexHtmlHeader := ("<!doctype html>
<html>
<head>
    <meta charset=\"utf-8\"/>
    <title>" .. 
    webSiteTitle .. 
    "-" ..
    webSiteDescription ..
    "</title>\n<link rel=\"stylesheet\" href=\"style.css\">
</head>
<body>
    <h3>" .. 
    webSiteTitle .. 
    "</h3><small>" .. 
    webSiteDescription .. 
    "</small>
    <p id=\"content\"><ul>") asUTF8

        indexHtmlBoby := """
</ul></p>
</body>
</html>
"""  asUTF8
        
        indexHtmlPath := htmlDir .. "/" .. "index.html"
        indexHtml := File with(indexHtmlPath)
        indexHtml remove
        indexHtml openForUpdating
        indexHtml write(indexHtmlHeader, Index articleListHtml, indexHtmlBoby)
        indexHtml close
        "\# index.html done!" println
    )
    // 生成所有文章页面
    writeAllArticleHtml := method(
        i := 0
        while(
            i < Index getArticleList size,
            k := Index getArticleList at(i) at(2)
            Article writeArticleHtml(k)
            i =i +1
        )
    )
)

/* 帮助
去掉注释即可执行
*/
Index writeIndexHtml // 生成首页
Index writeAllArticleHtml // 生成所有文章页面
//Article writeArticleHtml("about.md") // 生成单篇文章，参数为 markdown 文件名
