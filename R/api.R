
# Taken from trestletech/plumber

#' Return today's Date
#'
#' @export
#* @get /today
todayDate <- function(){
  lubridate::today()
}

#' Return current time stamp
#'
#' @export
#* @get /now
nowTime <- function(){
  lubridate::now()
}

