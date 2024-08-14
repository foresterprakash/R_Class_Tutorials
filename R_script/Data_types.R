# Numerical 

## Continuous -- numerical data

num <- 22.5

num1 <- 100

class(num)

## discrete -- Integer data

int <- 10L

class(int)

# Categorical

## Nominal

ch <- "Apple"

class(ch)

## Ordinal data 

## will be taught in factor data sets

library(lubridate)
## Date data type

d1 <- as.Date("1992-02-16 00:00")

d2 <- Sys.Date()

d3 <- as.Date.POSIXct(d1, tz = "America/New_York")

class(d3)

# d1 <- format(d1, format = "%Y/%m/%d")

# Date difference

as.numeric(d2 - d1)%/%365

as.numeric(d2-d1)%%365%/%30

as.numeric(d2-d1)%%365%%30

paste(as.numeric(d2 - d1)%/%365,"Years",
      as.numeric(d2-d1)%%365%/%30,"Months",
      as.numeric(d2-d1)%%365%%30,"Day", sep = " ")

# Data type conversion

ct <- as.integer(num1)

ctc <- as.character(num1)

ctn <- as.numeric(ch)

stx <- as.numeric(ctc)


## Matrix Data Set / Metrics




















