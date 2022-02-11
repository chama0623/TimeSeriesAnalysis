require(timevis)
require(forecast)
require(data.table)

# Gantt chart
# 対象のアクティブな期間を表している.
donations <- fread("./data/donations.csv")
d <- donations[, .(min(timestamp),max(timestamp)),user]
names(d) <- c("content","start","end")
d <- d[start !=end]
timevis(d[sample(1:nrow(d),20)])

# 年別の月々のカウント数 方法1
require(data.table)

air <- fread("./data/AirPassengers.csv")
names(air) = c("Date","Passengers")

air[, Date:= as.Date(paste0(Date, "-01"), format = "%Y-%m-%d")]
Passengers<-ts(air$Passengers,frequency=12,start=c(1949,1))

t(matrix(AirPassengers, nrow = 12, ncol = 12))
colors <- c("green","red","pink","blue","yellow","lightsalmon","black","gray","cyan","lightblue","maroon","purple")
matplot(matrix(AirPassengers, nrow = 12, ncol = 12),type="l",col=colors,lty=1,lwd=2.5,xaxt="n",ylab="Passenger Count")
legend("topleft",legend=1949:1960,lty=1,lwd=2.5,col=colors)
axis(1,at=1:12,labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))

# 方法2
seasonplot(AirPassengers)

# 年別の月ごとの曲線 方法1
months <-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
matplot(t(matrix(AirPassengers, nrow = 12, ncol = 12)),type="l",col=colors,lty=1,lwd=2.5)
legend("left",legend=months,col=colors,lty=1,lwd=2.5)

# 方法2
monthplot(AirPassengers)

# 2次元ヒストグラム その1
hist2d <- function(data,nbins.y,xlabels){
  ymin = min(data)
  ymax = max(data)*1.0001
  
  ybins = seq(from=ymin,to=ymax,length.out=nbins.y+1)
  
  hist.matrix = matrix(0, nrow = nbins.y, ncol = ncol(data))
  
  for(i in 1:nrow(data)){
    ts = findInterval(data[i, ],ybins)
    for(j in 1:ncol(data)){
      hist.matrix[ts[j],j] = hist.matrix[ts[j],j]+1
    }
  }
  hist.matrix
}

h = hist2d(t(matrix(AirPassengers, nrow = 12, ncol = 12)),5,months)
image(1:ncol(h),1:nrow(h),t(h),col=heat.colors(5),axes=FALSE,xlab="Time",ylab="Passenger Count")

# 2次元ヒストグラム その2
words <- fread("./data/url.str")
w1 <- words[V1==1]
h = hist2d(w1,25,1:ncol(w1))

colors <- gray.colors(20,start=1,end=.5)
par(mfrow=c(1,2))
image(1:ncol(h),1:nrow(h),t(h),col=colors,axes=FALSE,xlab="Time",ylab="Projection Value")
image(1:ncol(h),1:nrow(h),t(log(h)),col=colors,axes=FALSE,xlab="Time",ylab="Projection Value")