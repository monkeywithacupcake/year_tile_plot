# and now a function that makes a pretty contributions graph

#' Make Year Tile Plot
#' creates a yearly graph for any measure showing
#' the distribution of effort using any brewer palette
#' inspired by github contributions plot
#' code modified from https://restateinsight.com/posts/general-posts/2024-12-github-contributions-plot/
#'
#' @param year_df df with day and n
#' @param fill_palette string brewer palette; defaults to Blues but to make it look like github contributions, you would use 'Greens'
#'
#' @import ggplot2
#' @importFrom dplyr summarise
#'
#' @return ggplot object
#' @export
#'
#' @examples /dontrun{
#' fake <- data.frame(
#' date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "1 day"),
#'  n = sample(x = 0:10, size = 365, replace = TRUE)
#' )
#' # will print a distorted year tile plot (too)
#' make_year_tile_plot(year_df = make_year_df(df = fake, year = 2023))
# should have dimensions width = 5xheight to look correct
#'}
make_year_tile_plot <- function(year_df,
                               fill_palette = c('Blues','BuGn','BuPu','GnBu','Greens','Greys','Oranges','OrRd','PuBu','PuBuGn','PuRd','Purples','RdPu','Reds','YlGn','YlGnBu','YlOrBr','YlOrRd')) {

  fill_palette <- match.arg(fill_palette,
                            several.ok = FALSE)
  tab <- year_df |> # Find the positions of the month labels
    dplyr::summarise(nmin = min(n_week), .by = "month")

  ggplot2::ggplot(year_df, ggplot2::aes(n_week, weekday_label)) +
    geom_rtile(
      ggplot2::aes(fill = n),
      color = NA,
      width = 0.9,
      height = 0.9
    ) +
    # Highlight the months on the horizontal axis
    ggplot2::scale_x_continuous(
      breaks = tab$nmin,
      labels = as.character(tab$month),
      position = "top",
      expand = c(0, 0)
    ) +
    # Highlight days of the week on the vertical axis
    ggplot2::scale_y_discrete(breaks = c("Mon", "Wed", "Fri")) +
    # Adjust color palette
    ggplot2::scale_fill_distiller(
      palette = fill_palette,
      direction = 1,
      na.value = "gray90") +
    # Removes x and y labels
    ggplot2::labs(x = NULL, y = NULL) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      legend.position = "none",
      panel.grid = ggplot2::element_blank(),
      text = ggplot2::element_text(color = "gray10")
    )
}


#' Make and Export Year Tile PNG
#' creates the plot and exports to file
#' with the correct dimensions
#'
#' @param df data.frame like output of make_year_df
#' @param fill_palette string brewer palette. defaults to 'Greens'
#' @param path string path to save. defaults to 'mygraph.png'
#'
#' @importFrom grDevices png dev.off
#' @return saved png
#' @export
#'
#' @examples /dontrun{
#' fake <- data.frame(
#' date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "1 day"),
#'  n = sample(x = 0:10, size = 365, replace = TRUE)
#' )
#' make_and_export_year_tile_png(df = make_year_df(year = 2023, fake))
#'}
make_and_export_year_tile_png <- function(df,
                                   fill_palette = "Greens",
                                   path = "mygraph.png") {
  grDevices::png(filename=path, width=1000, height=200)
  print(make_year_tile_plot(year_df = df,
                           fill_palette = fill_palette))
  grDevices::dev.off()
}
