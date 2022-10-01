Hmk_05
================

Please read the entire [R for Data
Science](https://r4ds.had.co.nz/transform.html) before you do this
homework.

This homework relies on the `nycflights13` package, which contains
several data frames, including `airlines`, `airports`, `flights`,
`planes`, and `weather`. Loading `nycflights13` puts all of these data
frames on the search path, so that they are available automatically,
just like `mpg` or `mtcars`.

## Installing data packages

Remember that any package needs to be installed only once (per version
of R), but needs to be loaded every time we start a new R session.

To install `nyclflights13`, we use `install.packages("nycflights13")`
(with quotation marks). To load it, we use `library(nycflights13)`.

``` r
library(tidyverse)

library(nycflights13)
```

I already installed nycflights13, so I only had to load it after loading
tidyverse.

# Question 1: filtering

Make a plot of air time as a function of distance for all flights that
meet the following criteria:

-   originate from LaGuardia airport (“LGA”)
-   departed on the 16th of the month
-   have a flight distance of less than 2000

``` r
criteria <- filter(flights, origin == "LGA", day == 16, distance < 2000)

plot1 <- ggplot(criteria) +
  geom_point(aes(x = air_time, y = distance))
print(plot1)
```

    Warning: Removed 75 rows containing missing values (geom_point).

![](hmk_05_files/figure-gfm/unnamed-chunk-2-1.png)

# Question 2: dealing with NAs

Make a data frame of all of the rows of `flights` that have values for
*both* `arr_time` and `dep_time` - that is, neither of those values are
`NA`.

## filtering NAs

`ggplot()` will automatically remove NA values from the plot, as you may
have seen in question 1, but it emits a warning message about that. Of
course you could silence the warning message using [chunk
options](https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html),
but how could you prevent them from appearing in the first place?

``` r
criteria.2 <- filter(flights, origin == "LGA", day == 16, distance < 2000, air_time >= 0)

plot2 <- ggplot(criteria.2) +
  geom_point(aes(x = air_time, y = distance))
print(plot2)
```

![](hmk_05_files/figure-gfm/unnamed-chunk-3-1.png)

I initially tried using the `!(is.na(air_time))` but it still said that
there were five rows with missing data, but using the air_time \>= 0
gave no warnings.

# Question 3: adding columns

Create a data frame of average flight speeds, based on `air_time` and
`distance`. Make either a histogram or a density plot of the data. If
you like, you may break the data out (e.g. by airline, or some other
variable) in a way that you think makes sense.

``` r
avg.flight.speed <- mutate(flights, speed = distance/air_time)

plot3 <- ggplot(avg.flight.speed) +
  geom_histogram(aes(x = speed), na.rm=TRUE)
print(plot3)
```

    `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](hmk_05_files/figure-gfm/unnamed-chunk-4-1.png)

This time I used the `na.rm=TRUE` to block any error messages about
blank values.
