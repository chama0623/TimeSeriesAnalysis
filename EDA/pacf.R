# sin波を生成
x<-1:1000
y<- sin(x*pi/3)

# 偏相関をプロット
plot(y[1:30],type="b")
pacf(y)