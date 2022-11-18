HMK 8: summarising, reshaping, merging
================
Bailey Morgan

# Q1: Summarizing operations and exploratory data analysis

## Q1a.

Download `experiment1.csv` from Canvas (under files). This reports two
variables from an experiment that has four treatments. Creatively, the
treatments are `1`, `2`, `3`, and `4`, and the two variables are `x` and
`y`.

Create a data frame that contains the mean, standard deviation, and
number of points for each treatment. You will want to use functions like
`summarise()`, `group_by()`, `mean()`, and `sd()`.

``` r
library(tidyverse)

experiment1 <- read_csv("experiment1.csv")

grouped_balls <- group_by(experiment1, balls)

ball_stats <- summarize(grouped_balls, number = n(), xmean = mean(x), 
                        ymean = mean(y), xsd = sd(x), ysd = sd(y))
```

Are the data sets different in any important way?

The only difference between the groups is the y values, and the
distribution of the y values. Everything else is the same.

## Q1b

Now load the file `experiment2.csv`. Again, this describes two variables
for multiple treatments (here called `dataset`). Answer the same
questions as above.

``` r
experiment2 <- read_csv("experiment2.csv")
```

    Rows: 1846 Columns: 3
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (1): dataset
    dbl (2): x, y

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
grouped_dataset <- group_by(experiment2, dataset)

summarized_dataset <- summarise(grouped_dataset, number = n(), xmean = mean(x), 
                        ymean = mean(y), xsd = sd(x), ysd = sd(y))
```

This data has some small differences between datasets for the mean and
standard deviations of the x and y variables, but the differences are
incredibly small.

# Q2: pivoting

Create a plot that illustrates the differences in income among
religions, using the `relig_income` data set that is built into
tidyverse.

You will need to create a tidy data frame to do this.

``` r
new_relig_income <- pivot_longer(relig_income, !religion, names_to = "income", values_to = "count")

ggplot(new_relig_income, aes(x = income, y = count)) +
  geom_point()
```

![](hmk_08_files/figure-gfm/unnamed-chunk-3-1.png)

# Q3: merging

## Q3a: meaning of joins

Explain the difference between a left join, a right join, an inner join,
and an outer join.

`left_join()` joins two data frames, but keeps all rows present in the
“left” data frame, and omits rows from the right

`right_join()` joins two data frames, but keeps all rows present in the
“right” data frame, and omits rows from the left side

`inner_join()` joins two data frames, keeping all rows from each data
frame

`outer_join()` does not exist or is not recognized by R

## Q3b: using joins

Using the `flights` and `weather` data sets from `nycflights13`,
determine whether there is a correlation between average hourly wind
speed and departure delays at NY airports.

This is a question about joins: you will need to join the `flights` and
`weather` by year, month, day, and hour. However, note that `flights`
has encoded departure time in a particularly annoying way: as an
integers. For instance, the integer 517 indicates 5:17 am.

`weather` gives average weather conditions each hour, with the hour
given as an integer (e.g., 5 indicating 5-6 am). You’re going to have to
figure out how to convert the time in `flights` into a form that matches
the form in `weather`.

If you want, you can use the `lm()` function to make a linear model of
departure delay as a function of wind speed. But it is also fine to just
make a plot of the two variables with `geom_smooth()`.

``` r
flights <- nycflights13::flights
weather <- nycflights13::weather

new_flights <- mutate(flights, new_dep_time = round(dep_time, digits = -2) / 100)

joined_df <- left_join(x = new_flights, y = weather, 
                       by = c("year" = "year", 
                              "month" = "month", 
                              "day" = "day", 
                              "new_dep_time" = "hour"))

flights_plot <- ggplot(joined_df) +
  geom_smooth(aes(x = wind_speed, y = dep_delay), method = "lm")

print(flights_plot)
```

    `geom_smooth()` using formula 'y ~ x'

    Warning: Removed 10523 rows containing non-finite values (stat_smooth).

![](hmk_08_files/figure-gfm/unnamed-chunk-4-1.png)

Delays appear to increase as wind speed increases, but delays are not
dependent solely on wind speeds because there are still delays at low
winds speeds.
