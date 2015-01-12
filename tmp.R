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

svm.fit <- svm(V3 ~ V1 + V2, data = df, kernel = "polynomial", degree=2,gamma=1,coef0=1)

md <- ksvm(V3 ~ V1 + V2,data=df,kernel="polydot",kpar=list(degree=2,scale=1,offset=1),
           scaled=F)
md@alpha
y <- matrix(c(y1,y2,y3,y4,y5,y6,y7),7,1)
x <- rbind(x1,x2,x3,x4,x5,x6,x7)
xx <- x %*% t(x)
Q <- y %*% t(y) * (1 + xx)^2 
diag(Q) <-diag(Q) + 0.0000001


P <- matrix(rep(1,7),1,7)

A <- t(matrix(rep(y,7), 7,7))
 
c <- matrix(rep(0, 7),7,1)

# library(quadprog)
solve.QP(Q,P,t(A),c)

svm.fit <- svm(V3 ~ V1 + V2, data = df, kernel = "polynomial", degree=2,gamma=1,coef0=1)

library(RCurl)
a1 <- getURI("http://www.amlbook.com/data/zip/features.train")
a2 <- getURI("http://www.amlbook.com/data/zip/features.test")
train <- read.table(text = a1)
test <- read.table(text = a2)

library(dplyr)
# ``0'' versus ``not 0''
train0 <- train %>% mutate(V1 = ifelse(V1==0, 1, 0))

# ``2'' versus ``not 2''
train2 <- train %>% mutate(V1 = ifelse(V1==2, 1, 0))

# ``4'' versus ``not 4''
train4 <- train %>% mutate(V1 = ifelse(V1==4, 1, 0))

# ``6'' versus ``not 6''
train6 <- train %>% mutate(V1 = ifelse(V1==6, 1, 0))

# ``8'' versus ``not 8'' 
train8 <- train %>% mutate(V1 = ifelse(V1==8, 1, 0))

s1 <- ksvm(V1 ~ V2 + V3,data=train8,kernel="polydot",kpar=list(degree=2,scale=1,offset=1),
           C=0.01, scaled=F,type="C-svc")
sum(s1@alpha[[1]])




s2 <- svm(V1 ~ V2 + V3,data=train0,kernel="radial", gamma=100,cost=0.001,
          type="C-classification",scale=F)
p2 <- predict(s2, test[,-1])
sum(p2 != test[,1])/nrow(test)

s3 <- svm(V1 ~ V2 + V3,data=train0,kernel="radial", gamma=100,cost=0.01,
          type="C-classification",scale=F)
p3 <- predict(s3, test[,-1])
sum(p3 != test[,1])/nrow(test)

s4 <- svm(V1 ~ V2 + V3,data=train0,kernel="radial", gamma=100,cost=0.1,
          type="C-classification",scale=F)
p4 <- predict(s4, test[,-1])
sum(p4 != test[,1])/nrow(test)

s5 <- svm(V1 ~ V2 + V3,data=train0,kernel="radial", gamma=100,cost=1,
          type="C-classification",scale=F)
p5 <- predict(s5, test[,-1])
sum(p5 != test[,1])/nrow(test)

s6 <- svm(V1 ~ V2 + V3,data=train0,kernel="radial", gamma=100,cost=10,
          type="C-classification",scale=F)
p6 <- predict(s6, test[,-1])
sum(p6 != test[,1])/nrow(test)




s4 <- svm(V1 ~ V2 + V3,data=train0,kernel="radial", gamma=1000,cost=0.1,
          type="C-classification",scale=F)
p4 <- predict(s4, test[,-1])
sum(p4 != test[,1])/nrow(test)


rr <- c(1,10,100,1000,10000)


i <- 0
res_r <- c()
while (i < 100){
  ind <- sample(1:nrow(train0), 1000)
  t0 <- train0[-ind, ]
  t1 <- train0[ind, ]
  res_rate <- c()
  for (r in rr){
    s4 <- svm(V1 ~ V2 + V3,data=t0,kernel="radial", gamma=r,cost=0.1,
              type="C-classification",scale=F)
    p4 <- predict(s4, t1[,-1])
    rate <- sum(p4 != t1[,1])/nrow(t1)
    res_rate <- c(res_rate, rate)
  }
  res_r <- c(res_r, rr[which.min(res_rate)])
  i <- i + 1
}
