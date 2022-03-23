require(data.table)

air <- fread("./data/AirPassengers.csv")
names(air) = c("Date","Passengers")

air[, Date:= as.Date(paste0(Date, "-01"), format = "%Y-%m-%d")]
Passengers<-ts(air$Passengers,frequency=12,start=c(1949,1))
acf(Passengers)
pacf(Passengers)