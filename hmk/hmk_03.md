Homework 3
================
Bailey Morgan

# Homework 3

Please download this template, fill it out, and submit it as homework.

# Data input/output

Use the tidyverse `read_csv()` function to read a .csv file of your own
data. If you don’t have any data of your own, make up an excel file with
fake data.

A few notes:

-   In order to work with `read_csv()`, the first row of the spreadsheet
    should contain the names of the columns, and all other rows should
    contain data
-   To export the data as a .csv, go to “save as” and select File Format
    “UTF-8 csv” or similar.
-   Save the file in the same directory as your homework `.qmd` file.
-   Quarto/knitr make a new R session when they run, and the home
    directory of that session is the directory that the file is saved
    in. So if your `.qmd` file is in `micr_595/hmk`, and you save the
    `.csv` file as `micr_595/hmk/my_data.csv`, you would load the file
    as `read_csv("my_data.csv")`.
-   Sometimes R and Excel disagree on the end of a .csv file. If you get
    extra lines containing `NA`, don’t worry about it.

``` r
library(tidyverse)
```

The tidyverse package is opened for use in the file.

``` r
read_csv("060121_Proxzyme.csv")
```

    Rows: 4 Columns: 6
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (1): Time
    dbl (5): No DNA, No Target, (-) Target, (+) Target, EAD2

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    # A tibble: 4 × 6
      Time   `No DNA` `No Target` `(-) Target` `(+) Target`  EAD2
      <chr>     <dbl>       <dbl>        <dbl>        <dbl> <dbl>
    1 2 min     0.071       0.281        0.109        0.349 0.855
    2 4 min     0.086       0.415        0.152        0.471 1.3  
    3 8 min     0.113       0.652        0.231        0.711 2.08 
    4 16 min    0.155       1.15         0.373        1.33  1.42 

``` r
new_data <- read_csv("060121_Proxzyme.csv")
```

    Rows: 4 Columns: 6
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (1): Time
    dbl (5): No DNA, No Target, (-) Target, (+) Target, EAD2

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

The data is presented in a table. The data matches the data from the
original file.

# Investigating the properties of data frames

Use two different functions that both give some kind of summary or
overview of the data frame. Which one do you think is more useful?

``` r
new_data$`(+) Target`
```

    [1] 0.349 0.471 0.711 1.327

``` r
str(new_data$`(-) Target`)
```

     num [1:4] 0.109 0.152 0.231 0.373

``` r
str(new_data)
```

    spec_tbl_df [4 × 6] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
     $ Time      : chr [1:4] "2 min" "4 min" "8 min" "16 min"
     $ No DNA    : num [1:4] 0.071 0.086 0.113 0.155
     $ No Target : num [1:4] 0.281 0.415 0.652 1.15
     $ (-) Target: num [1:4] 0.109 0.152 0.231 0.373
     $ (+) Target: num [1:4] 0.349 0.471 0.711 1.327
     $ EAD2      : num [1:4] 0.855 1.3 2.08 1.422
     - attr(*, "spec")=
      .. cols(
      ..   Time = col_character(),
      ..   `No DNA` = col_double(),
      ..   `No Target` = col_double(),
      ..   `(-) Target` = col_double(),
      ..   `(+) Target` = col_double(),
      ..   EAD2 = col_double()
      .. )
     - attr(*, "problems")=<externalptr> 

The str function shows much more information than the other, which could
be helpful for large data sets that have many different types of data.
But when all of that information isn’t needed, the first option is
better.

# Manipulating data frames

Create a new column of your data frame by performing some kind of
arithmetic operation on an existing column.

``` r
new_data$EAD2 - new_data$`No DNA`
```

    [1] 0.784 1.214 1.967 1.267

I subtracted the values in the No DNA column from the EAD2 column.

# Working on columns

Calculate the mean of a numeric column in your data frame.

``` r
mean(new_data$`(+) Target`)
```

    [1] 0.7145

# Accessing elements of data frames

-   [Challenge 3 from SC Data Structures
    lesson](https://swcarpentry.github.io/r-novice-gapminder/04-data-structures-part1/index.html#challenge-3):
    Show what each of the following returns, and explain what each line
    of code is doing:
    -   `cats[1]`
        -   this prints all of the values in the first column of the
            data frame
    -   `cats[[1]]`
        -   this prints all of the values in the first row of the data
            frame
    -   `cats$coat`
        -   similar to the first one, this one prints all the values in
            the column, but by name.
    -   `cats[1, 1]`
        -   this prints the single value in the first row of the first
            column
    -   `cats[ , 1]`
        -   this prints the values of x row in column 1, another way of
            writing cats\[1\], and cats\$coat
    -   `cats[1, ]`
        -   this prints the values of 1 row in column x, similar to
            cats\[\[1\]\]

# Optional challenge

A data frame is an example of a list. I haven’t discussed how to access
elements of lists, but it is covered
[here](https://swcarpentry.github.io/r-novice-gapminder/04-data-structures-part1/index.html#lists)).

Explain in what ways accessing elements of lists are like accessing
columns of data frames, and given that, how it shows that data frames
are a type of list.
