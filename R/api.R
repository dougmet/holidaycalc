
# Taken from trestletech/plumber

#* @get /today
todayDate <- function(){
  lubridate::today()
}


#* @get /now
nowTime <- function(){
  lubridate::now()
}

# Call the longestRun function
#
#* @get /longrun
longrun <- function(start, end, daysleave) {
  daysleave <- as.integer(daysleave)
  holidaycalc::longestRun(startDate = start, endDate = end, daysLeave = daysleave)
}
