# 原系列のヒストグラム
hist(EuStockMarkets[,"SMI"],30)

# 差分のヒストグラム
hist(diff(EuStockMarkets[,"SMI"],30))