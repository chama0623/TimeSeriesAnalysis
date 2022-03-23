# 原系列の散布図
plot(EuStockMarkets[,"SMI"],EuStockMarkets[,"DAX"])

# 差分の散布図
plot(diff(EuStockMarkets[,"SMI"]),diff(EuStockMarkets[,"DAX"]))

# 1ラグ前の差分SMIとラグがない差分DAXの散布図
plot(lag(diff(EuStockMarkets[,"SMI"]),1),diff(EuStockMarkets[,"DAX"]))