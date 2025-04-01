# from https://restateinsight.com/posts/general-posts/2024-12-github-contributions-plot/

`%||%` <- function(a, b) {
  if(is.null(a)) b else a
}

GeomRtile <- ggplot2::ggproto(
  "GeomRtile",
  statebins:::GeomRrect, # 1) only change compared to ggplot2:::GeomTile

  extra_params = c("na.rm"),
  setup_data = function(data, params) {
    data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
    data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)

    transform(data,
              xmin = x - width / 2,  xmax = x + width / 2,  width = NULL,
              ymin = y - height / 2, ymax = y + height / 2, height = NULL
    )
  },
  default_aes = ggplot2::aes(
    fill = "grey20", colour = NA, size = 0.1, linetype = 1,
    alpha = NA, width = NA, height = NA
  ),
  required_aes = c("x", "y"),

  # These aes columns are created by setup_data(). They need to be listed here so
  # that GeomRect$handle_na() properly removes any bars that fall outside the defined
  # limits, not just those for which x and y are outside the limits
  non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),
  draw_key = ggplot2::draw_key_polygon
)

#' geom_rtile a rounded tile
#'
#' This function is minorly changed from Vinicius Oike
#' https://restateinsight.com/posts/general-posts/2024-12-github-contributions-plot/
#'
#' @param mapping mapping or NULL
#' @param data data or NULL
#' @param stat string 'identity'
#' @param position string 'identity'
#' @param radius unit object desired for curve. default to grid::unit(2, "pt")
#' @param na.rm boolean. default to FALSE
#' @param show.legend NA
#' @param inherit.aes boolean. default to FALSE
#'
#' @seealso [grid::unit()]
#'
#' @return a ggproto tile
#' @export
#'
#' @examples \dontrun{
#' ggplot(contributions, aes(n_week, weekday_label)) +
#' geom_rtile(
#' aes(fill = n),
#' color = NA,
#' width = 0.9,
#' height = 0.9
#' )
#' }
geom_rtile <- function(mapping = NULL, data = NULL,
                       stat = "identity", position = "identity",
                       radius = grid::unit(2, "pt"),
                       ...,
                       na.rm = FALSE,
                       show.legend = NA,
                       inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomRtile,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(
      radius = radius,
      ...,
      na.rm = na.rm
    )
  )
}


