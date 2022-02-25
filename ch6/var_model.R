require(forecast)
library(vars)

demand <- fread("data/Daily_Demand_Forecasting_Orders.csv",sep=";")
demand<-ts(demand)

est.var <- VAR(demand[, 11:12],lag.max=4,type="const")
print(est.var)

par(mfrow=c(2,1)) # 図を分割表示
plot(demand[,"Banking orders (2)"],type="l")
lines(fitted(est.var)[,1],col=2)
plot(demand[,"Banking orders (3)"],type="l")
lines(fitted(est.var)[,2],col=2)

par(mfrow=c(2,1)) # 図を分割表示
acf(demand[,"Banking orders (2)"]-fitted(est.var)[,1])
acf(demand[,"Banking orders (3)"]-fitted(est.var)[,2])

# かばん検定 : 2つの系列に系列相関があるかか検定
print(serial.test(est.var,lags.pt=8,type="PT.asymptotic"))