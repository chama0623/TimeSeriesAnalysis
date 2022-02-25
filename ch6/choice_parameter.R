require(forecast)
# データ生成 実際にはパラメータは不明であるとして扱う
set.seed(1017)
y=arima.sim(n=1000,list(ar=c(0.8,-0.4),ma=c(-0.7)))

# 原系列
plot(y)
acf(y)
pacf(y)

# 手作業でモデルを推定する
# ARIMA(p,d,q) = (1,0,1)
ar1.ma1.model = Arima(y,order=c(1,0,1))
par(mfrow=c(2,1)) # 図を分割表示
acf(ar1.ma1.model$residuals)
pacf(ar1.ma1.model$residuals)

# ARIMA(p,d,q) = (2,0,1)
ar2.ma1.model = Arima(y,order=c(2,0,1))
plot(y,type="l")
lines(ar2.ma1.model$fitted,col=2)
plot(y,ar2.ma1.model$fitted)
par(mfrow=c(2,1)) # 図を分割表示
acf(ar2.ma1.model$residuals)
pacf(ar2.ma1.model$residuals)

# ARIMA(p,d,q) = (2,0,2)
ar2.ma2.model = Arima(y,order=c(2,0,2))
plot(y,type="l")
lines(ar2.ma2.model$fitted,col=2)
plot(y,ar2.ma2.model$fitted)
par(mfrow=c(2,1)) # 図を分割表示
acf(ar2.ma2.model$residuals)
pacf(ar2.ma2.model$residuals)

# ARIMA(p,d,q) = (2,1,2)
ar2.d1.ma2.model = Arima(y,order=c(2,1,2))
plot(y,type="l")
lines(ar2.d1.ma2.model$fitted,col=2)
plot(y,ar2.d1.ma2.model$fitted)
par(mfrow=c(2,1)) # 図を分割表示
acf(ar2.d1.ma2.model$residuals)
pacf(ar2.d1.ma2.model$residuals)

print(cor(y,ar1.ma1.model$fitted))
print(cor(y,ar2.ma1.model$fitted))
print(cor(y,ar2.ma2.model$fitted))
print(cor(y,ar2.d1.ma2.model$fitted))



# 自動でモデルを推定する
est = auto.arima(y,stepwise=FALSE,max.p=3,max.q=9)
print(est)