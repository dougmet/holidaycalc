
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

  # TODO Allow other calendars
  x <- isWorking(startDate, endDate)

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

  dates = as.Date(names(y)[y==daysLeave])

  list(window = win, dates = dates)
}

