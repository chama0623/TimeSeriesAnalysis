# ロケットの位置推定
# タイムステップ
ts.length <- 100
# 加速度 rep関数は第一引数の値を第二引数回反復する
a <- rep(0.5, ts.length)

# 位置と速度(初期値はどちらも0), 2秒ごとに測定
x <- rep(0, ts.length)
v <- rep(0, ts.length)
for (ts in 2:ts.length){
  x[ts] <- v[ts-1]*2+x[ts-1]+1/2* a[ts-1]^2
  x[ts] <- x[ts] + rnorm(1, sd=20) # 確率項付加
  v[ts] <- v[ts-1]+2*a[ts-1]
}
# 位置, 速度, 加速度をプロット
par(mfrow=c(3,1))
plot(x,main="Position", type="l")
plot(v,main="Velocity", type="l")
plot(a,main="Acceleration", type="l")

# 観測値の生成(xにセンサノイズをさらに付加)
par(mfrow=c(1,1))
z <- x + rnorm(ts.length,sd=300)
plot(x,ylim=range(c(x,z)))
lines(z)

# カルマンフィルタ
kalman.motion <- function(z,Q,R,A,H){
  dimState = dim(Q)[1]
  xhatminus <- array(rep(0,ts.length*dimState),
                     c(ts.length,dimState))
  xhat <- array(rep(0,ts.length*dimState),
                     c(ts.length,dimState))
  
  Pminus <- array(rep(0,ts.length*dimState*dimState),
                  c(ts.length,dimState,dimState))
  P <- array(rep(0,ts.length*dimState*dimState),
                  c(ts.length,dimState,dimState))
  
  K <- array(rep(0,ts.length*dimState),
             c(ts.length,dimState))
  
  # 初期の推定 全ての指標を0で開始する
  xhat[1,] <- rep(0,dimState)
  P[1, , ] <- diag(dimState) # dimStateを対角成分に持つ対角行列を生成
  
  for(k in 2:ts.length){
    # 予測ステップ
    xhatminus[k, ]<- A %*% matrix(xhat[k-1, ]) # 行列の積ABはA %*% B
    Pminus[k, , ] <- A %*% P[k-1, , ] %*% t(A)+Q
    
    # フィルタリングステップ
    K[k, ] <- Pminus[k, , ]%*% H %*%
      solve(t(H) %*% Pminus[k, , ] %*% H +R)
    xhat[k, ] <- xhatminus[k, ] + K[k, ] %*%
      (z[k] - t(H) %*% xhatminus[k, ])
    P[k, , ] <- (diag(dimState) - K[k, ] %*% t(H)) %*% Pminus[k, , ]
  }
  return(list(xhat=xhat,xhatminus=xhatminus))
}

# パラメータ設定
R <- 10^2
Q <- 10
A <- matrix(1)
H <- matrix(1)

xhat <- kalman.motion(z,diag(1)*Q,R,A,H)[[1]]
xhatminus <- kalman.motion(z, diag(1) * Q, R, A, H)[[2]]

plot(z, ylim = range(c(x, z)), type = 'l',
     col = "black",  lwd = 2)
lines(x,         col = "red",    lwd = 2, lty = 2)
lines(xhat,      col = "orange", lwd = 1, lty = 3)
lines(xhatminus, col = "blue",   lwd = 1, lty = 4)
legend("topleft", 
       legend = c("Measured", "Actual", "Filtered", "Forecast"),
       col = c("black", "red", "orange", "blue"), 
       lty = 1:4)