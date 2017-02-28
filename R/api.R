
# Taken from trestletech/plumber

#' Return today's Date
#'
#' @export
#* @get /today
todayDate <- function(){
  lubridate::today()
}

