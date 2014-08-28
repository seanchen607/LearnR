## R中的一些函数

- `noquote`去掉引号

- `state.name`美国州名，`letters` `LETTERS`26个字母, `month.abb` `month.name`月名

- `sprintf` 表示string print按一定格式把若干个组件组合成字符串

- `.Last.value`查看最后一个结果

- `suppressMessages`隐藏警告信息

- `apropos('lm', mode = "function)`包含lm的函数，支持正则表达式。`ls(pattern='ut')` 包含字符串ut的对象。

- `capabilities()`

- `signif(x,digits=n)` 将x舍为指定的有效数字位数

- `commandArgs` 设置命令行参数

- `trunc(x)`向0的方向截取的x中的整数部分,`trunc(-1.5)`, `floor(-1.5)`.

- `Sys.setlocale("LC_TIME", "English")`将汉字变为英文。

- `object.size(a)`查看a占用的内存情况，使用`storage.mode(x)`查看对象存数的模式。

- `locator()`图上取点的位置。

- 查看当前时间 `date()`, `Sys.time()`,lubridate包中的`now()`.

- 排序相关的函数sort(),rank(),order()。    
  sort(x)是对向量x进行排序，返回值排序后的数值向量。rank()是求秩的函数，它的返回值是这个向量中对应元素的“排名”。而order()的返回值是对应“排名”的元素所在向量中的位置。

## R中的一些小技巧

- 将数字转化位因子 
 
```r
df <- data.frame(a = c(0,1,0), b = 1:3)  
df$a<-factor(df$a,labels=c("F","M"))  
df   
```
- remove package from the search path

```r
detach("package:ggplot2")
```

- `search()`查看当前所加载的包

- 出现的图形可以用`Ctrl+W`或`Ctrl+C`来复制粘贴，前者像素高

- 使用`??rlm`来查找那个包包含`rlm`这个函数。使用`help`函数时，特殊字符和一些保留字必须用引号括起来。`?">"`，`?"for"`
查询生成多元正太分布的函数 用命令`help.search("multivariate normal")`或者`??"multivariate normal"`

- 数据框提取也可以用`df[[i]]`

- 最好一开始就定义好一个大矩阵。这个事先定义好的矩阵是空的，但是再循环过程中逐行或列进行复制，这种做法避免了循环过程中每次进行耗时的矩阵内存分配。

- `x&&y`标量的逻辑“与”运算，`x&y`向量的逻辑“与”运算

- 绘图时，标题太长要换行，用`\n`或用`strwrap`函数，可以自定义段落格式。

- 添加默认加载包
```r
pkgs <- getOption("defaultPackages")           # Get system list of packages to load
pkgs <- c(pkgs, "zoo")                         # Append "zoo" to list
options(defaultPackages = pkgs)                # Update configuration option
rm(pkgs)                                       # Clean up our temp variable
```
- linux下 R -g Tk & 这条命令使R在背景下运行它自己的窗口。Tk指的是图形用户界面所用到的一个图形库。

- qchisq(c(0.5,0.95),df=2)计算自由度为2的卡方分布的50%分位数和95%分位数

- `textConnection`输入或输出文字连接，注意里面有引号。
```r
df <- read.table(textConnection('1,23\n1,23'),sep=',')
```

- 画图时坐标轴的排序方式，B,C,A会排成A,B,C，使用下面方法来校正
```r
a$name <- factor(a$name, levels=unique(a$name))
levels(a$name) = c('B','C','A')
```

- x$y is equivalent to `x[["y", exact = FALSE]]`

- `scan`的一个最普遍的应用是读入大的矩阵。假定文件matrix.dat只是包括一个200 x 2000的矩阵，那么我们可用
```r
A <- matrix(scan("matrix.dat", n = 200*2000), 200, 2000, byrow = TRUE)
```

- 提取变量    
> [ always returns an object of the same class as the original; can be used to select more than one element (there is one exception)  
> [[ is used to extract elements of a list or a data frame; it can only be used to extract a single element and the class of the returned object will not necessarily be a list or data frame  
> $ is used to extract elements of a list or data frame by name; semantics are similar to hat of [[.  
`sapply(name,"[",2) ` 

- 编写函数时，参数中有...的作用  
> The ... argument indicate a variable number of arguments that are usually passed on to other functions  
> The ... argument is also necessary when the number of arguments passed to the function cannot be known in advance.  
> One catch with ... is that any arguments that appear after ... on the argument list must be named explicitly and cannot be partially matched.

- 查找index  
  The function match works on vectors :
```r
x <- sample(1:10)
x
# [1]  4  5  9  3  8  1  6 10  7  2
match(c(4,8),x)
# [1] 1 5
```
  match only returns the first encounter of a match,as you requested.  
  For multiple matching, %in% is the way to go:  
```r
x <- sample(1:4,10,replace=T)
x
# [1] 3 4 3 3 2 3 1 1 2 2
which(x %in% c(2,4))
# [1]  2  5  9 10  
```
- 使用parse()函数将字符串转化为表达式(expression)，而后使用eval()函数对表达式求解。
```r
x <- 1:10
a <- "print( x )"
class(a)
eval(parse(text = a)) 
```

- ubuntu下安装R包，`apt-get install r-cran-rmysql`自动解决各种依赖

- 统计分布  
>d for density  
>r for random number generation  
>p for cumulative distribution  
>q for quantile function  

- 一次读取两行，从文件开始处重新读取，使用seek()
```r
c <- file("za","r")  
readLines(c,n=2) 
seek(con=c,where=0)
```

- 画个图
```r
plot(1, type = "n")
text(1, 1, "\\VE", cex = 20, vfont = c("serif", "plain"))
```

- 时间处理,lubridate包  
时间格式  

>POSIXct is just a very large integer under the hood;it use a useful class when you want to store times in something like a data frame   
>POSIXct, which stores seconds since UNIX epoch (+some other data)   
>POSIXlt is a list underneath and it stores a bunch of other useful information like the day of the week,day of the year,month,day of the month  
>POSIXlt, which stores a list of day, month, year, hour, minute, second, etc. 
  
```r
x <- Sys.time()
class(x) ## Already in `POSIXct' format  
unclass(x)
x$sec
## Error: $ operator is invalid for atomic vectors
p <- as.POSIXlt(x)
p$sec
unclass(p)
```   
还可以查看min,hour,mday,mon,year,wday,yday, etc  

>strptime()根据你指定的格式控制字符串解读日期。strptime is a function to directly convert character vectors (of a variety of formats) to POSIXlt format.  
>strftime()则根据你指定的格式控制字符串输出日期。

生成连续的时间
```r
seq(ISOdate(2010,1,1), by='day', length=365)
seq(ymd('2014-01-01'), ymd('2014-03-02'), by = ddays(3))
```

计算年龄  
```r
age = new_interval(ymd('1989-09-27'), now()) / duration(num = 1, units = "years")
```

- 将缺失值替换为前一个数  
zoo包中的`na.locf`函数
MIfuns这个包里的两个指令：`locf` 和 `reapply`.
```r
x1 <- data.frame(subject = c("a", "a", "b", "b"),
                 time = c(1,2,1,2),
                 score = c(50, NA, 100, NA)
                 )

x2 <- transform(
      x1,
      score = reapply(
              score,
              INDEX = subject,
              FUN = locf
               )
      )
```





