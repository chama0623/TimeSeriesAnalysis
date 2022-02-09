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

# 移動平均
rand.unemp[,impute.rm.nolookahead :=rollapply(c(NA,NA,UNRATE),3,
                                              function(x){
                                                if(!is.na(x[3])) x[3] else mean(x,na.rm=TRUE)
                                              })]
bias.unemp[,impute.rm.nolookahead :=rollapply(c(NA,NA,UNRATE),3,
                                              function(x){
                                                if(!is.na(x[3])) x[3] else mean(x,na.rm=TRUE)
                                              })]

# 350~400までをプロット
unemp[350:400,plot(DATE,UNRATE,col=1,lwd=2,type="b")]
rand.unemp[350:400,lines(DATE, impute.rm.nolookahead, col=2,lwd=2,lty=2)]
rand.unemp[350:400,rpt==TRUE,points(DATE,impute.rm.nolookahead,col=2,pch=6,cex=2)]