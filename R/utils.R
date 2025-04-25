
limit_dates_to_year <- function(year, df, date_var = 'date'){
  v <- df[df[,c(date_var)] >= paste0(year,'-01-01') &
            df[,c(date_var)] <= paste0(year,'-12-31'),]
  if(!nrow(v) == nrow(df)){
    warning("not all dates are in year", year,
            "df filtered and now contains", nrow(v), "rows")
  }
  return(v)
}

#' Is Date?
#' Internal Function to check that an object
#' is a date
#'
#' @param x vector, ideally of dates
#'
is_date <- function(x) {
  inherits(x, c("Date", "POSIXt"))
}
