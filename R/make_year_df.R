#' Make Year DF
#'
#' Note that you do not have to make this intermediate
#' data frame. See the example in `make_year_tile_plot()`.
#'
#' @param df data.frame with data to plot.
#' If omitted, returns make_empty_year_df() which
#' you can join manually to an n
#' @param year numeric defaults to 2024
#' @param date_var string should represent the date var
#' @param n_var string should represent the counter to be plotted
#'#'
#' @return data.frame with columns needed for year_tile_plot
#' @export
#'
#' @examples
#' fake <- data.frame(
#' date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "1 day"),
#'  n = sample(x = 0:10, size = 365, replace = TRUE)
#' )
#' make_year_df(year = 2023, df = fake)
make_year_df <- function(df, year = 2024, date_var = "date", n_var = "n"){

  if(missing(df)){
    # just return an empty year
    message("no df passed, returning results of `make_empty_year_df`")
    return(make_empty_year_df(year))
  }
  # day_df has to have cols date_var and n_var
  stopifnot("var names not correct" = c(date_var, n_var) %in% names(df))

  # is date_var a date?
  if(!is_date(df[,c(date_var)])){
    stop(paste(date_var, "in df is not a date"))
  }
  tmp <- data.frame(
    date = df[,c(date_var)],
    n = df[,c(n_var)]
  )
  tmp <- aggregate(n ~ date, tmp, sum)

  yr_df <- make_empty_year_df(year)
  yr_df <- merge(yr_df, tmp, all.x = TRUE)
  yr_df$n <- ifelse(yr_df$n ==0, NA, yr_df$n)

  return(yr_df)

}

#' Make Empty Year DF
#'
#' @param year numeric defaults to 2024
#'
#' @return data.frame with columns needed for year_tile_plot
#' @export
#'
#' @importFrom dplyr mutate
#' @importFrom lubridate week wday month
#'
#' @examples
#' tmp <- make_empty_year_df()
#'
#' # can submit a year
#' tmp <- make_empty_year_df('2012')
make_empty_year_df <- function(year = 2024){
  # TODO: make this year checker more robust
  year <- as.numeric(year) # a checker
  yr_df <- data.frame(
    date = seq(as.Date(paste0(year,"-01-01")),
               as.Date(paste0(year,"-12-31")),
               by = "1 day")
  )
  yr_df <- yr_df |>
    dplyr::mutate(
      n_week = lubridate::week(date),
      n_day = lubridate::wday(date, week_start = 7),
      n_week = ifelse(n_day == 1, n_week + 1, n_week),
      weekday_label = lubridate::wday(date, week_start = 7,
                                      label = TRUE, abbr = TRUE),
      #weekday_label = forcats::fct_rev(weekday_label),
      month = lubridate::month(date, label = TRUE, abbr = TRUE),
      is_weekday = ifelse(n_day == 7 | n_day == 1, 0L, 1L)
    )
  yr_df$weekday_label <- factor(yr_df$weekday_label, levels = rev(levels(yr_df$weekday_label)))
  return(yr_df)
}
