
# yeartileplot

<!-- badges: start -->
<!-- badges: end -->

The goal of yeartileplot is to ...

## Installation

You can install the development version of yeartileplot from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("monkeywithacupcake/year_tile_plot")
```

## Example

This is a basic example which shows you how to solve a common problem:

```r
 # make some fake data 
 fake <- data.frame(
 date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "1 day"),
  n = sample(x = 0:10, size = 365, replace = TRUE)
 )
 
 # will make a year tile plot 
 # will appear distorted (too tall if dimensions are wrong)
 make_year_tile_png(df = make_year_df(year = 2023, fake))
 
 # should have dimensions width = 5xheight to look correct
 # the make and export will do it in one go
 make_and_export_year_tile_png(df = make_year_df(year = 2023, fake),
                               fill_palette = "Purples")
 # will result in the following image
```

![Example in Purple](man/figures/mygraph.png?raw=true "My Year Plot")


