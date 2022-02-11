# データを生成
x <- rnorm(n=100,mean = 0, sd=10)+1:100

plot(x,type="l",lwd=1)
# 最大値
# lwd : 線分の幅 大きいと太くなる
# lty : 実線, 破線の指定
lines(cummax(x),col=2,lwd=3,lty=2)
# 平均値
lines(cumsum(x)/1:length(x),col=3,lwd=3,lty=3)