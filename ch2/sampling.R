# load package
require(zoo)
require(data.table)

# load data
unemp <- fread("UNRATE.csv")
# translate column "DATE" to datetime object
unemp[, DATE :=as.Date(DATE)]
setkey(unemp,DATE)

# データが無作為に欠損しているデータセットを生成
rand.unemp.idx <- sample(1:nrow(unemp), .1*nrow(unemp))
rand.unemp <- unemp[-rand.unemp.idx]

# 失業率の高い月にデータが欠損値している可能性の高いデータセットを生成
high.unemp.idx <- which(unemp$UNRATE>8)
num.to.select <- .2*length(high.unemp.idx)
high.unemp.idx <- sample(high.unemp.idx,)
bias.unemp <- unemp[-high.unemp.idx]

# ローリング結合
all.dates <-seq(from = unemp$DATE[1],to = tail(unemp$DATE,1),by="months")
rand.unemp = rand.unemp[J(all.dates),roll=0]
bias.unemp = bias.unemp[J(all.dates),roll=0]
rand.unemp[,rpt :=is.na(UNRATE)]

# 1年ごとにダウンサンプリング
unemp[seq.int(from=1, to = nrow(unemp),by=12)]

# 年平均にダウンサンプリング
unemp[,mean(UNRATE),by=format(DATE,"%Y")]

# 不規則データを規則データにアップサンプリング
all.dates <- seq(from = unemp$DATE[1],to=tail(unemp$DATE,1),by="months")
rand.unemp = rand.unemp[J(all.dates),roll=0]

# 入力が異なる頻度でサンプリングされている場合
dailys.unemployment = unemp[J(all.dates),roll=31]
dailys.unemployment