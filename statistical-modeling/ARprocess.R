require(forecast)

demand <- fread("data/Daily_Demand_Forecasting_Orders.csv",sep=";")
demand<-ts(demand$`Banking orders (2)`)
plot(demand)
acf(demand)
pacf(demand)

# ARモデル 次数はAICで自動的に決定
fit <- ar(demand,method="mle")
print(fit)

# ARIMAモデル (AR(3))
est <- arima(x=demand,order = c(3,0,0))
print(est)

# 係数を強制的に0にする
est.1 <- arima(x=demand,order = c(3,0,0),fixed=c(0,NA,NA,NA))
print(est.1)

# 残差のACFをプロット
acf(est.1$residuals)

# リュング-ボックス検定
Box.test(est.1$residuals,lag=10,type="Ljung",fitdf=3)

# 1タイムステップ先の予測
plot(demand)
lines(fitted(est.1),col=3,lwd=2)

# 3タイムステップ先の予測
plot(demand)
lines(fitted(est.1,h=3),col=3,lwd=2)