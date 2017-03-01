
#' Find the longest run of holiday given a budget of leave days
#'
#' @param startDate Date or international format string. Beginning of your search range.
#' @param endDate Date or international format string. End of your search range.
#' @param daysLeave How many days leave you want to use.
#'
#' @return A list with window (the length of holiday) and the available start dates.
#' @export
#'
#' @examples
#' longestRun("2017-01-01", "2018-01-10", 10)
#' longestRun("2017-01-01", "2018-01-10", 3)
longestRun <- function(startDate, endDate, daysLeave) {

  startDate <- as.Date(startDate)
  endDate <- as.Date(endDate)

  # Extract the years
  sy = as.numeric(format(startDate, "%Y"))
  ey = as.numeric(format(endDate, "%Y"))

  # Create all the dates in between
  dates <- seq(startDate, endDate, by = "day")

  # TODO Allow other calendars
  x <- timeDate::isBizday(timeDate::as.timeDate(dates), holidays = timeDate::holidayLONDON(sy:ey))

  # Start with a biggish window
  win <- 2*daysLeave
  y <- .cumsumroll(x, k = win)
  # See if we need to move window up or down
  while(min(y) <= daysLeave) {
    win <- win + 1
    y <- .cumsumroll(x, k = win)
  }
  while(min(y) > daysLeave) {
    win <- win - 1
    y <- .cumsumroll(x, k = win)
  }

  runDates = as.Date(names(y)[y==daysLeave])

  list(window = win, dates = runDates)
}


.cumsumroll <- function(x, k = 3) {
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
