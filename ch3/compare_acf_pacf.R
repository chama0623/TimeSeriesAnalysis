# ノイズのない周期が異なる正弦波
# sin波を生成
x<-1:1000
y1<- sin(x*pi/3)
y2<- sin(x*pi/10)

plot(y1[1:100],type="b")
acf(y1)
pacf(y1)

plot(y2[1:100],type="b")
acf(y2)
pacf(y2)

# y1とy2の和の系列
y <- y1+y2
plot(y[1:30],type="b")
acf(y)
pacf(y)

# 低ノイズがある周期が異なる正弦波
noise1 <- rnorm(100,sd=0.05)
noise2 <- rnorm(100,sd=0.05)

y1<-y1+noise1
y2<-y2+noise2
y <- y1+y2

plot(y1[1:100],type="b")
acf(y1,lag.max=30)
pacf(y1,lag.max=30)

plot(y2[1:100],type="b")
acf(y2,lag.max=30)
pacf(y2,lag.max=30)

plot(y[1:100],type="b")
acf(y,lag.max=30)
pacf(y,lag.max=30)

# 高ノイズがある周期が異なる正弦波
y1<- sin(x*pi/3)
y2<- sin(x*pi/10)
noise1 <- rnorm(100,sd=0.3)
noise2 <- rnorm(100,sd=0.3)

y1<-y1+noise1
y2<-y2+noise2
y <- y1+y2

plot(y1[1:100],type="b")
acf(y1,lag.max=30)
pacf(y1,lag.max=30)

plot(y2[1:100],type="b")
acf(y2,lag.max=30)
pacf(y2,lag.max=30)

plot(y[1:100],type="b")
acf(y,lag.max=30)
pacf(y,lag.max=30)