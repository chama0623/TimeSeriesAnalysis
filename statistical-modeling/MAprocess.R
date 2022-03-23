require(forecast)

demand <- fread("data/Daily_Demand_Forecasting_Orders.csv",sep=";")
demand<-ts(demand$`Banking orders (2)`)

# MA(9)-process
ma.est = arima(x=demand,order=c(0,0,9),fixed = c(0,0,NA,rep(0,5),NA,NA))
print(ma.est)

# リュング-ボックス検定
Box.test(ma.est$residuals,lag=10,type="Ljung",fitdf=3)

# 1期先予測
print(fitted(ma.est,h=1))

#10期先予測(平均回帰)
print(fitted(ma.est,h=10))