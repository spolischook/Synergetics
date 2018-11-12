logisticDistribution <- function(start = 2.98, end = 4, by=0.003, iterations=c(800, 1000)) {
  logistic.map <- function(r, x, N, M){
    ## r: bifurcation parameter
    ## x: initial value
    ## N: number of iteration
    ## M: number of iteration points to be returned
    z <- 1:N
    z[1] <- x
    for (i in c(1:(N-1))) {
      z[i+1] <- r *z[i]  * (1 - z[i])
    }
    ## Return the last M iterations
    z[c((N-M):N)]
  }

  ## Set scanning range for bifurcation parameter r
  my.r <- seq(start, end, by=by)
  system.time(Orbit <- sapply(my.r, logistic.map,  x=0.1, N=iterations[2], M=iterations[1]))
  ##   user  system elapsed (on a 2.4GHz Core2Duo)
  ##   2.910   0.018   2.919

  Orbit <- as.vector(Orbit)
  r <- sort(rep(my.r, iterations[1]+1))

  plot(Orbit ~ r, pch=".")
}

logisticDistribution(2.98, 3.5, 0.0001, c(500, 1000))
