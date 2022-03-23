# データを生成
x <- rnorm(n=100,mean = 0, sd=10)+1:100
# 1/nをn回繰り返す要素を生成
mn <- function(n) rep(1/n,n)

plot(x,type="l",lwd=1)
#filter(x,mn(n))でn次の移動平均平滑化を計算
lines(filter(x,mn(5)),col=2,lwd=3,lty=2)
lines(filter(x,mn(50)),col=3,lwd=3,lty=3)