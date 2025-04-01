# year_tile_plot

Makes a year tile plot like a github contributions graph.

```r
 fake <- data.frame(
 date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "1 day"),
  n = sample(x = 0:10, size = 365, replace = TRUE)
 )
 # will print a distorted year tile plot (too)
 make_year_tile_png(df = make_year_df(year = 2023, fake))
 # should have dimensions width = 5xheight to look correct
 make_and_export_year_tile_png(df = make_year_df(year = 2023, fake),
                               fill_palette = "Purples")
 # will result in the following image
```

![Example in Purple](man/figures/mygraph.png?raw=true "My Year Plot")

#### TODO: finish writing readme
