library(grid)

nextX <- function(x, r)
{
    return (x = r * x * (1 - x))
}

q_map <- function(r=1, x_o=runif(1, 0, 1), N=100, burn_in=0, ...)
{
    par(mfrow = c(2, 1), mar = c(4, 4, 1, 2), lwd = 0.6)
    ############# Trace #############
    x <- array(dim = N)
    x[1] <- x_o
    for (i in 2 : N)
        x[i] <- r * x[i - 1] * (1 - x[i - 1])

    plot(x[(burn_in + 1) : N], type = 'l', xlab = 't', ylab = 'x', ...)
    #################################

    ##########  Quadradic Map ########
    x <- seq(from = 0, to = 1, length.out = 100)
    x_np1 <- array(dim = 100)
    for (i in 1 : length(x))
        x_np1[i] <- r * x[i] * (1 - x[i])

    plot(x, x_np1, type = 'l', xlab = expression(x[t]), ylab = expression(x[t + 1]))
    abline(0, 1)

    start = x_o
    vert = FALSE

    if (burn_in == 0) {
        lines(x = c(start, start), y = c(0, r * start * (1 - start)))
    }

    for (i in 1 : (2 * N))
    {
        if (burn_in > i/2) {
            start <- nextX(start, r)
            next
        }

        if (vert)
        {
            lines(
                x = c(start, start),
                y = c(start, nextX(start, r))
            )
        }
        else
        {
            lines(
                x = c(start, nextX(start, r)),
                y = c(nextX(start, r), nextX(start, r))
            )
            start <- nextX(start, r)
        }

        vert=!vert
     }
    #################################
}

# For run this
# q_map(3.1, 0.2, 1000, burn_in=980)
