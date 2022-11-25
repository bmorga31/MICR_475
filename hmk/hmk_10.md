Homework 10: Decisions and loops
================
Bailey Morgan

# Decisions

Write a function that accepts the current time as a parameter and prints
“Good morning”, “Good afternoon”, or “Good evening” depending on the
time. It is fine for the time to be in numeric format (e.g., `2317` for
11:17 pm). Bonus points if the function accepts time objects (see the
`lubridate` package).

A few questions to consider:

- What is a logical name for this function? What is a logical name for
  the parameter it accepts?
- The purpose of this function is to print a message to the console, so
  its primary purpose is a **side effect**. However, all functions must
  return something. What would be a logical value for this function to
  return?
- Should the function have default behavior in case the user does not
  pass an argument?
- What would you like to happen if this function is passed the wrong
  data type (e.g., a negative number)?

``` r
library(tidyverse)

current_time <- -5

# check_time <- function(the.time) {
#   if(the.time < 1200) {
#     print("good morning")
#   } else if(the.time >= 1800) {
#     print("good evening")
#   } else {
#     print("good afternoon")
#   }
# }

check_time <- function(the.time) {
  if(the.time >= 0 & the.time < 1200) {
    print("good morning")
  } else if(the.time >= 1800 & the.time < 2400) {
    print("good evening")
  } else if(the.time >= 1200 & the.time < 1800) {
    print("good afternoon")
  } else {
    print("not a time")
  }
}

check_time(current_time)
```

    [1] "not a time"

My initial attempt in-class worked as long as the assigned time was, in
fact, a time. However, that function would take any number greater than
1800 and say “good evening”, and any number less than 0 and say “good
morning”. In order to ensure that it will only give a statement to valid
times, more strict parameters must be set for each `if()` statement.

# Loops

- Write a `for` loops that calculates the mean of each column of mtcars

``` r
mtcars.avgs <- rep(NA, length(mtcars))
for(i in seq_along(mtcars)) {
  mtcars.avgs[i] <- mean(mtcars[[i]])
}
print(mtcars.avgs)
```

     [1]  20.090625   6.187500 230.721875 146.687500   3.596563   3.217250
     [7]  17.848750   0.437500   0.406250   3.687500   2.812500

- Write a function (using a for loop) that calculates the mean of all
  numeric columns of *any* data frame. This function should be able to
  accept data frames with non-numeric columns.

``` r
anymean <- function(df) {
  col.mean <- rep(NA, length(df))
  for(i in seq_along(df)) {
    if(is.numeric(df [[i]])) {
      col.mean[i] <- mean(df [[i]])
    } else if (!is.numeric(df [[i]])) {
      col.mean[i] <- NA 
    } 
  }
  col.mean
}
anymean(mpg)
```

     [1]          NA          NA    3.471795 2003.500000    5.888889          NA
     [7]          NA   16.858974   23.440171          NA          NA

``` r
anymean(diamonds)
```

     [1]    0.7979397           NA           NA           NA   61.7494049
     [6]   57.4571839 3932.7997219    5.7311572    5.7345260    3.5387338

This uses most of the same stuff as above, but is put into a function so
it can apply to any data frame and contain the if/else if part, which
was included to account for non-numeric values.

## Why not loops

In R, we generally encourage people to use vectorized functions instead
of `for` loops. According to [your
textbook](https://r4ds.had.co.nz/iteration.html), what is better about
vectorized functions?

`For` loops can get very complicated and aren’t specific, which means
that trying to do a lot of stuff with a loop violates the copy-and-paste
rule that the authors of the book seem very passionate about (which I
don’t get, but maybe that’s why I’m not very good at this coding thing).
The `for` loop has to go back and look at each part of the input
separately to get the output, whereas the vectorized functions act on
all parts of the input (vector).
