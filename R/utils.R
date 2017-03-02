
# Rolling cumulative sum
#
# Directly equivalent to \code{zoo:rollsum(x,k,align='left')}
#
# @param x Numeric vector
# @param k Integer size of rolling window
#
.cumsumroll <- function(x, k = 3L) {
  if(k<2) {
    y <- as.numeric(x)
  } else {
    y <- cumsum(x)[-(1:(k-1))] - cumsum(c(0,x[-(length(x):(length(x) - k +1))]))
    if(!is.null(names(x))) {
      names(y) <- names(x)[-(length(x):(length(x) - k + 2))] # like a zoo::rollsum(align="left")
    }
  }
  y
}
