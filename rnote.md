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

- 查看当前时间 `date()`, `Sys.time()`,`Sys.Date()`,lubridate包中的`now()`.

- 排序相关的函数sort(),rank(),order()。    
  sort(x)是对向量x进行排序，返回值排序后的数值向量。rank()是求秩的函数，它的返回值是这个向量中对应元素的“排名”。而order()的返回值是对应“排名”的元素所在向量中的位置。
  
- `scale`中心化scale(center = T, scale = F), 标准化scale(center = T, scale = T)

- `eval(parse(text="1+1"))`    

- `setdiff(x,y)` x中有y中没有。

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
>d for density  密度函数   
>r for random number generation  分布函数   
>p for cumulative distribution  分位数函数   
>q for quantile function  生成随机数   

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
[时间处理](https://rpubs.com/jo_irisson/howto_date_time)     
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

生成连续的时间?`seq.Date`
```r
seq(ISOdate(2010,1,1), by='day', length=365)
seq(ymd('2014-01-01'), ymd('2014-03-02'), by = ddays(3)) # 现在运行不了了
seq(as.Date('2011-01-01'),as.Date('2011-01-31'),by = 1)
as.Date("2000-01-01") + 0:10
xts::timeBasedSeq("2011-08-01::2011-08-31")
seq(ymd('2012-04-07'),ymd('2013-03-22'), by = '1 week')
seq(ymd('2012-04-07'),ymd('2013-03-22'), by = 'weeks')
```

计算年龄  
```r
age = new_interval(ymd('1989-09-27'), now()) / duration(num = 1, units = "years")

days <- difftime(as.Date(Sys.Date()), as.Date('1989-09-27'), units='days')
age <- as.numeric(days) / 365
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

- R包`directlabels`给图加标签，`ggthemes`提供主题模板，和ggplot2配合着用。   

- read.delim就是在read.table里面设置了几个默认参数  
```r
read.table(file, header = TRUE, sep = "\t", quote = "\"", dec = ".", fill = TRUE, comment.char = "")
```
可以读取后缀为.data的文件。

- 分组操作
```r
h1 <- y77 %>% group_by(lr_c, value_c) %>% do(as.data.frame(table(.$leiji)))
#or
h2 <- ddply(y77, c("lr_c", "value_c"), summarise, qj = as.data.frame(table(y77$leiji))[,1], freq = as.data.frame(table(y77$leiji))[,2])
```

- 训练了一个模型，`ls(modelFit)`来查看里面有些什么东西。

- 正则表达式 A character class is a list of characters enclosed between [ and ] which matches any single character in that list;
Two regular expressions may be joined by the infix operator |;
```r
# 用|和()来多个条件匹配
grepl('(Eastern Europe)|(Eastern Erope)', train$Main.Markets, ignore.case = T)
```
1、元字符 `. \ | ( ) [ { $ * + ?` 用`\\.`来表示. 用`\\\\`来表示\

2、The truth is that regmatches() is the only function that is designed to work with regex patterns. regmatches() extract or replace matches use with data from regexpr(),
gregexpr() or regexec()

4、gregexpr() returns a list of the same length as text 

5、可以用sub提取内容，如用\\1提取匹配的第一个组。`sub(pattern, "\\1", text)`

7、R语言中提取字符串中的汉字

`gsub('[^\u4e00-\u9fa5]', '', s)` 将非汉字全部替换为空

8、匹配括号中的内容
```r
r <- regexec("[\\(\\（](.*?)[\\)\\）]", n2$GoodsName)
#or
r <- sub('.*\\((.*?)\\).*', '\\1', text)
m <- regmatches(n2$GoodsName, r)
n2$colour <- sapply(m, function(x) x[2])
```

- 编码

像'ÖÐÎÄ1'这种样子的乱码是因为原来的编码就是GBK，读进来之后要用`iconv(xxx,"GBK","UTF-8")`转成UTF-8，然后就正常了。像'ï»¿ä¸­æ–‡1'这样的乱码说明原文本是UTF-8，但是在当前R环境下Encoding不正常，需要`Encoding(xxx) <- "UTF-8"`，然后再操作

- `dplyr`包

```r
tally(group_by(batting_tbl, yearID), sort = TRUE) # 等价于
batting_tbl %>% group_by(yearID) %>% summarise(f=n()) %>% arrange(desc(f)) # 等价于
batting_tbl %>% count(yearID, sort = TRUE)
```
```r
summarise_each(funs(mean), Cancelled, Diverted) 
summarise_each(funs(min(., na.rm=TRUE), max(., na.rm=TRUE)), matches("Delay")) #allows you to apply the same summary function to multiple columns at once
#几个求个数的函数
top_n()
n()
n_distinct()
#glimpse()类似于str()
flights %>% sample_n(5) #随机取5个
flights %>% sample_frac(0.25, replace=TRUE) #随机取四分之一
row_number(); min_rank()
select() #use `contains` `starts_with`, `ends_with`, and `matches` (for regular expressions) can be used to match columns by name
```
- `Hmisc`中的`cut2`函数可代替cut用。

- 主成分分析
```r
pr <- princomp(data, cor = T)
pr$sdev^2  #特征值
pr$loadings #特征向量默认小于0.1的不打印除pr$loadings[,1:2]查看
summary(pr) #贡献率
pr$scores #主成份得分
```
- [Window functions](http://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html)

- 最优化函数 optim

- 读取网页数据   
```r
library(RCurl)
x1 <- getURL("https://d396qusza40orc.cloudfront.net/ntumlone%2Fhw4%2Fhw4_train.dat")
train <- read.table(text = x1)
```

- `switch`函数相比`if`来说速度更快，而且代码较短、整洁，以后要注意使用。  
使用ifelse时注意第一个参数是一个向量，而不是标量。   

- 广义线性回归  
```r
glm(formula, family=binomial(link="logit"), data) # 逻辑回归
glm(formula, family=poisson(link="log"), data) # 泊松回归
glm(formula, family=gaussian(link="identity"), data) # 标准线性模型
```

- 频数    
```r
library(dplyr)   
batting_tbl %>% count(playerID, wt = G) #等价于   
batting_tbl %>% group_by(playerID) %>% summarise(n=sum(G))   
```

- `dplyr`中group_by完之后，可以用`ungroup`来去掉group的属性。

- `within`可以用来操作数据框，增加变量：
  ```r
aq <- within(airquality, {     # Notice that multiple vars can be changed
    lOzone <- log(Ozone)
    Month <- factor(month.abb[Month])
    cTemp <- round((Temp - 32) * 5/9, 1) # From Fahrenheit to Celsius
    S.cT <- Solar.R / cTemp  # using the newly created variable
    rm(Day, Temp)})
  ```

- 微分`deriv` 积分`integrate`

- 对多个变量`group_by`之后写入Excel
```r
test <- c("men_n", "PERFUME_n")
for (t in test){
  c2 <- c1 %>% group_by(flag,c1[, t]) %>% summarise(f=n_distinct(CONTACT_ID)) %>% as.data.frame
  names(c2)[2] <- t
  rownames(c2) <- NULL # Set row.names to FALSE to avoid the first column being row names.
  write.xlsx(c2, 'test.xlsx', sheetName=t, row.names=F, append=T)
}
```

- `formatC`,`sprintf`  **C语言**风格格式。

- 聚类  [选择最佳k](http://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters?rq=1),   [变量选择及思路介绍sas](http://blog.sina.com.cn/s/blog_5d3b177c0100equm.html), [sas聚类](http://493420337.iteye.com/blog/836393)

- 包`stringi`处理编码。

- windows上连接sqlserver数据库  
```r
library(RODBC)
a1 <- odbcDriverConnect(connection="server=111.111.10.11; database=sdf; uid=sa;
                        pwd=*********;driver={SQL Server};")
bigodata_appdata <- sqlQuery(a1, 'select * from data', stringsAsFactors = F)
odbcClose(a1)
```

- `do.call(grid.arrange, c(gt, ncol=4, nrow=4))` 原来list里还能设置参数。

- [Plot matrix with the R package GGally](https://tgmstat.wordpress.com/2013/11/13/plot-matrix-with-the-r-package-ggally/)

- 在windows系统上更新R  
```r
install.packages("installr"); 
library(installr)
updateR() # updating R
```
- 比较日期   
```r
ymd('2013-12-31')-months(1)
ymd('2013-12-31')-duration(num=1, units="months")
ymd('2013-01-01') > '2013-01-01'
as.POSIXct('2013-01-01') > '2013-01-01'
ymd('2013-01-01') > '2013-01-02'
比较日期的时候as.POSIXct转化
```
- 时间
`ymd`和`as.POSIXct`转换成的日期时区不同，`ymd`是UTC（Universal Time Coordinated 世界协调时间），时间比北京时间晚8小时；`as.POSIXct`是CST（China Standard Time），应该是与操作系统的时区一致。
```r
ymd('2015-05-20') == as.POSIXct('2015-05-20')
# [1] FALSE
ymd('2015-05-20') > as.POSIXct('2015-05-20')
# [1] TRUE
```


- [将数据中的因子变量改为字符串](http://stackoverflow.com/questions/2851015/convert-data-frame-columns-from-factors-to-characters)
```r
bob <- data.frame(lapply(bob, as.character), stringsAsFactors=FALSE)
bob[] <- lapply(bob, as.character) # 数值型的也会变为字符
# 只改变是因子的变量
i <- sapply(bob, is.factor)
bob[i] <- lapply(bob[i], as.character)
```
- 在centos6.x中安装R
```r
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum install R
```
- 在window中添加环境变量
```r
R.home('bin')
```
- [在Linux中安装rJava](http://stackoverflow.com/questions/3311940/r-rjava-package-install-failing)

- 使用RJDBC或RHive连接hive
```r
Sys.setenv(HADOOP_HOME="/opt/cloudera/parcels/CDH/lib/hadoop")
Sys.setenv(HIVE_HOME="/opt/cloudera/parcels/CDH/lib/hive")

library(RHive)
rhive.init()

library(RJDBC)
options( java.parameters = "-Xmx8g" )
drv <- JDBC("org.apache.hive.jdbc.HiveDriver", "/opt/cloudera/parcels/CDH/lib/hive/lib/hive-jdbc.jar") # jdbc
conn <- dbConnect(drv, "jdbc:hive2://111.111.11.11:10000/mydatabase", "**", "*********") # jdbc

rhive.connect('111.111.11.11',defaultFS='hdfs://namenode1:8020',hiveServer2=T,user='***', password='*********') # rhive

```

- RJDBC连接sql server，下载[sqljdbc4.jar](http://www.microsoft.com/en-us/download/details.aspx?displaylang=en&id=11774)，但是库里的日期导进来会变成字符，而RODBC不是这样
```r
library(RJDBC)
drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver" , "/root/sqljdbc4.jar")
conn1 <- dbConnect(drv, "jdbc:sqlserver://111.111.11.11;databaseName=Aptamil_Ofusion_ODS", "**", "****")
```
- `readr`包：
readr不用再写stringsAsFactors = FALSE了，不会变为因子
可以读取压缩文件
col_names: 相当于base中header，TRUE; FALSE; 自己指定
col_types: 相当于base中的colClasses
progress：显示加载进度，如果读取时间超过5s
永远不会自动将字符型转为因子
会显示前10行
永远不会设置row names
```r
read_csv("iris.csv", col_types = list(
  Sepal.Length = col_double(),
  Sepal.Width = col_double(),
  Petal.Length = col_double(),
  Petal.Width = col_double(),
  Species = col_factor(c("setosa", "versicolor", "virginica"))
))
```

- 指定读取数据时日期的格式
```r
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

tmp <- c("1, 15/08/2008", "2, 23/05/2010")
con <- textConnection(tmp)

tmp2 <- read.csv(con, colClasses=c('numeric','myDate'), header=FALSE)
str(tmp2)
```
- 在linux上使用ODBC来读取sqlserver数据
用R在Linux下连接MSSQL，需要安装
```bash
apt-get install libiodbc2-dev
apt-get install libiodbc2
apt-get install unixodbc-dev
apt-get install libmyodbc
apt-get install tdsodbc
```

安装freetds
解压后，执行命令
```bash
./configure --prefix=/usr/local/freetds
make
sudo make install
```
需要配置freeTDS.conf、odbcinst.ini、odbc.ini这3个文件
freetds.conf 路径是：/usr/local/freetds/etc/freetds.conf
```
# A typical Microsoft server
[test]
host = 115.29.201.33
port = 1433
tds version = 7.0
```
/etc/odbcinst.ini
```
[test]
Description   = FreeTDS unixODBC Driver
Driver        = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so
Setup         = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so
```
/etc/odbc.ini
```
[test]
Description = Shiny testing
Driver = FreeTDS
# TDS-Version = 7.2
TDS_Version = 8.0
Trace = No
Server = 115.29.201.33
Database = mydatabase
port = 1433
```
[报错修改](http://stackoverflow.com/questions/24493749/rodbc-ms-sql-access-from-ubuntu-using-freetds)
`conn <- odbcConnect("test", "uname", "passwd")`



