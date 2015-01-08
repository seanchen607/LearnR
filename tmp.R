x1=c(1,0);y1=-1
x2=c(0,1);y2=-1
x3=c(0,-1);y3=-1
x4=c(-1,0);y4=+1
x5=c(0,2);y5=+1
x6=c(0,-2);y6=+1
x7=c(-2,0);y7=+1

rbind(eval(parse(text=paste0('x',1:7))))
rbind(parse(text=paste0('x',1:7)))

library(magrittr)
df <- cbind(rbind(x1,x2,x3,x4,x5,x6,x7), c(y1,y2,y3,y4,y5,y6,y7))
df %<>% as.data.frame()

df$V4 <- df$V2 ^2 - 2 * df$V1 + 3
df$V5 <- df$V1 ^2 - 2 * df$V2 - 3

library(ggplot2)
ggplot(df, aes(x=V1, y=V2, color=factor(V3))) + geom_point()

svm.fit <- svm(V3 ~ V1 + V2, data = df, kernel = "polynomial", degree=2)

y <- matrix(c(y1,y2,y3,y4,y5,y6,y7),7,1)
x <- rbind(x1,x2,x3,x4,x5,x6,x7)
xx <- x %*% t(x)
Q <- y %*% t(y) * (1 + xx)^2 
Q <- Q + matrix(rep(1, 49)*0.00000001, 7, 7)

P <- matrix(rep(-1,7),7,1)

A <- t(matrix(rep(y,7), 7,7))
 
c <- matrix(rep(0, 7),7,1)
