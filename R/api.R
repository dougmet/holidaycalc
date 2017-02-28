
# Taken from trestletech/plumber

#' Mean of Normals
#'
#' Given a number of samples calculate the mean of
#' the standard normals
#'
#' @param samples integer
#'
#' @export
#* @get /mean
normalMean <- function(samples=10){
  data <- stats::rnorm(samples)
  mean(data)
}

#' Add Two
#'
#' @param a number 1
#' @param b number 2
#' @return a + b
#' @export
#* @post /sum
addTwo <- function(a, b){
  as.numeric(a) + as.numeric(b)
}
