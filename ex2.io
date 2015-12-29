# 第一种注释的方式，运行程序的时候，这些是看不见的
"一、我是看得见的，上面的注释是看不见的" println
// 第二种注释的方式
"二、我是看得见的，上面的注释是看不见的" println
/* 第三种注释的方式，通常用于大段注释
中间写上任何东西都不会影响，比如"双引号"
 */
"three. the comment is ignored" println

s := " world"
("hello" .. s) println