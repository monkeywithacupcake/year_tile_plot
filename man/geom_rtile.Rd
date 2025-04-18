% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_rtile.R
\name{geom_rtile}
\alias{geom_rtile}
\title{geom_rtile a rounded tile}
\usage{
geom_rtile(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  radius = grid::unit(2, "pt"),
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
}
\arguments{
\item{mapping}{mapping or NULL}

\item{data}{data or NULL}

\item{stat}{string 'identity'}

\item{position}{string 'identity'}

\item{radius}{unit object desired for curve. default to grid::unit(2, "pt")}

\item{na.rm}{boolean. default to FALSE}

\item{show.legend}{NA}

\item{inherit.aes}{boolean. default to FALSE}
}
\value{
a ggproto tile
}
\description{
This function is minorly changed from Vinicius Oike
https://restateinsight.com/posts/general-posts/2024-12-github-contributions-plot/
}
\examples{
\dontrun{
ggplot(contributions, aes(n_week, weekday_label)) +
geom_rtile(
aes(fill = n),
color = NA,
width = 0.9,
height = 0.9
)
}
}
\seealso{
[grid::unit()]
}
