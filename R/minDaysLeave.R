
#' Find the best time to take a fixed length holiday
#'
#' @param startDate Date or international format string. Beginning of your search range.
#' @param endDate Date or international format string. End of your search range.
#' @param window The number of consecutive days holiday you would like.
#' E.g. 3 weeks would be 21 (or 23 if you want an extra weekend)
#'
#' @return A list with the minimum days needed and a vector of potential start dates
#' @export
#'
#' @examples
#' minDaysLeave("2017-01-01", "2018-01-10", 23)
minDaysLeave <- function(startDate, endDate, window) {

  x <- isWorking(startDate, endDate)

  y <- .cumsumroll(x, k = window)

  minDays <- min(y)
  dates <- names(y[y==minDays])

  list(minDays = minDays, dates = dates)

}
