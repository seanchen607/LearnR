- 将数字转化位因子

`
df <- data.frame(a = c(0,1,0), b = 1:3)  
df$a<-factor(df$a,labels=c("F","M"))  
df   
`

- remove package from the search path

`
detach("package:ggplot2")
`

- `search()`查看当前所加载的包

- 出现的图形可以用`Ctrl+W`或`Ctrl+C`来复制粘贴，前者像素高


