
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

# Create a logical sequence of dates
#
# Given a date range, create a date sequence with every day in between and then
# create a vector which is true if it's a working day
#
# @param startDate
# @param endDate
# @param country
#
# @return
isWorking <- function(startDate, endDate, country="UK") {

  # TODO Argument checking

  holFunction <- switch(country, UK = timeDate::holidayLONDON,
                        stop("Must be UK for now. Sorry."))

  startDate <- as.Date(startDate)
  endDate <- as.Date(endDate)

  # Extract the years
  sy = as.numeric(format(startDate, "%Y"))
  ey = as.numeric(format(endDate, "%Y"))

  # Create all the dates in between
  dates <- seq(startDate, endDate, by = "day")

  # TODO Allow other calendars
  x <- timeDate::isBizday(timeDate::as.timeDate(dates), holidays = holFunction(sy:ey))

  x

}
