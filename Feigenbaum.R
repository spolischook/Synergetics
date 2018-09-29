# Title     : Feigenbaum model
# Objective : make a Feigenbaum model plot
# Created by: Serhii Polishchuk
# Created on: 9/18/18

x <- seq(0, 1, by=0.001)

Fg <- function(λ = 1, x) {
    return (λ*x*(1-x))
}

buildFg <- function(λ = 1) {
    plot(Fg(λ, x), xaxt="n", type="l", main="Feigenbaum model", xlab="X", ylab=sprintf("λ*x*(1-x); λ=%s", λ))
    axis(1, at=0:1000, labels=x)
    abline(coef(line(x)), col=2)
}

buildFg(10)
