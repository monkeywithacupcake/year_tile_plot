#' Make Year DF
#'
#' @param year numeric defaults to 2024
#' @param day_df data.frame expected to have cols date and n
#'
#' @return data.frame with columns needed for year_tile_plot
#' @export
#'
#' @examples
#' fake <- data.frame(
#' date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "1 day"),
#'  n = sample(x = 0:10, size = 365, replace = TRUE)
#' )
#' make_year_df(year = 2023, day_df = fake)
make_year_df <- function(year = 2024, day_df){
  # day_df has to have cols date and n
  stopifnot("must have date and n as colnames" = c("date","n") %in% names(day_df))
  yr_df <- data.frame(
    date = seq(as.Date(paste0(year,"-01-01")),
               as.Date(paste0(year,"-12-31")),
               by = "1 day")
  )
  yr_df |>
    dplyr::left_join(dplyr::select(day_df, date, n)) |>
    dplyr::mutate(
      n_week = lubridate::week(date),
      n_day = lubridate::wday(date, week_start = 7),
      weekday_label = lubridate::wday(date, week_start = 7,
                                      label = TRUE, abbr = TRUE),
      weekday_label = forcats::fct_rev(weekday_label),
      month = lubridate::month(date, label = TRUE, abbr = TRUE),
      is_weekday = ifelse(n_day == 7 | n_day == 1, 0L, 1L)
    ) |>
    dplyr::mutate(
      n = ifelse(n == 0, NA, n),
      n_week = ifelse(n_day == 1, n_week + 1, n_week)
    )
}
