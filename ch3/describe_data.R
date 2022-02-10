# データセットとして4つの欧州株価指数の
# 1991～1998までの毎日の終値のデータを用いる.

# データの先頭5行を表示
print(head(EuStockMarkets))

# 時系列をプロット
plot(EuStockMarkets)

# 1年あたりのデータ頻度
print(frequency(EuStockMarkets))

# 開始・終了時刻を求める
print(start(EuStockMarkets))
print(end(EuStockMarkets))

# 時間断面の抽出
print(window(EuStockMarkets,start=1997,end=1998))