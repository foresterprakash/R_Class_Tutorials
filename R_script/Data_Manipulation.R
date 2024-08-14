## Here we will learn about the DPLYR package in R 

# pipe function %>%
# install.packages("dplyr")
# Acquire data

library(dplyr) # load package

# Alternative way of loading package

#install.packages("pacman")

pacman::p_load(dplyr)

#pacman::p_unload(dplyr) to unload the packages

## pipe operator

str(mtcars)

mtcars$mpg[4] <- "apple"
str(mtcars)
mtcars$mpg  <- as.numeric(mtcars$mpg)
str(mtcars)
## Now delete the environment
rm(list = ls())
str(mtcars)


# Select desired columns by name
mtcars %>%
  select(mpg,wt,gear,vs) %>%
  head(5)

# Select desired columns by index
mtcars %>%
  select(1,8,10) %>%
  head()

# arrange columns by name or index

mtcars %>%
  select(sort(names(mtcars),decreasing = FALSE)) %>%
  head()

mtcars %>%
  select(1,4,2,6,3,8,4,9,5,7,11,10) %>%
  head()

mtcars %>%
  select(rev(names(mtcars))) %>%
  head()

mtcars %>%
  select(-4,-8) %>%
  head()

#### Filter 

# this function filters the rows by the logical statement
# logical statements are based on single or multiple columns
# two or more logical statement will be connected by or / and (|)  / (&)

summary(mtcars)

mtcars %>%
  filter(hp > 150 & mpg > 15 & gear == 5)

mtcars %>%
  filter(hp > 350 | mpg >25)


## Distinct 

## This function removes the duplicate rows

mtcars %>%
  distinct(cyl,am,.keep_all = TRUE) 

## slice function

mtcars %>%
  slice(1,5,10)

mtcars %>%
  slice(seq(from = 1, to = nrow(mtcars),by = 3))

mtcars %>%
  slice_head(n = 5)

names(mtcars)

mtcars$carname <- row.names(mtcars)

rm(list = ls())

mtcars %>%
  slice_max(mpg,n = 3,with_ties = TRUE)

iris %>%
  slice_sample(n = 10)

iris %>%
  slice_sample(prop = 0.05)

iris %>%
  group_by(Species) %>%
  slice_sample(n = 3)

iris %>%
  group_by(Species) %>%
  slice_sample(prop = 0.1)

iris %>%
  group_by(Species)%>%
  slice_max(Sepal.Length, n = 3, with_ties = FALSE)

### Arrange function 

iris %>% arrange(desc(Sepal.Length),Sepal.Width)

library(gapminder)

gapminder %>% head()

gapminder %>%
  filter(country == "Afghanistan" & year == 1952) %>% 
  select(pop)
  

gapminder %>%
  filter(continent == "Asia") %>%
  select(pop) %>%
  sum()


gapminder %>%
  filter(continent == "Asia" & year == 1952) %>%
  select(pop) %>%
  summarise(sum(pop))

gapminder %>%
  filter(continent == "Asia" & year == 1952) %>%
  select(pop) %>%
  summarise(mean(pop))

gapminder %>%
  filter(continent == "Asia" & year == 1952) %>%
  select(pop) %>%
  count()

# gapminder %>% select(year) %>% max()

gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(mean(pop), min(pop), max(pop), median(pop), sd(pop))

gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(mean(pop),mean(lifeExp),mean(gdpPercap))

# Now with name of column also
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(population = mean(pop),
            Life_Expectancy = mean(lifeExp),
            Gdp = mean(gdpPercap))


# single variable with multiple description summary
library(dplyr)
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(n = n(),
            min = min(pop),
            mean = mean(pop),
            max = max(pop),
            median = median(pop),
            sd = sd(pop))

gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(
    across(
    c(pop,lifeExp,gdpPercap),
    list(min,mean,max,median,sd))
    ) 

gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(
    across(
      c(pop,lifeExp,gdpPercap),
      list(min,mean,max,median,sd)
    )
  )

# count 

gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  count()

# Data Modification Function 

## Mutate / Rename

## Mutate adds the column in the data frame

## Rename change the name of column

names(gapminder)

gapminder %>%
  mutate(National_GDP = pop * gdpPercap)



gapminder %>%
  mutate(National_GDP_million = (pop * gdpPercap)/10^6)

len = runif(n= 10, min = 25, max = 50)
bd = runif(n = 10, min = 50, max = 60)

dat <- data.frame(length = len, breadth = bd)


dat %>% mutate(area = length * breadth)


# Base R 

dat$area <- dat$length * dat$breadth

## Rename 

names(gapminder)

gapminder %>%
  rename(Population = pop, Life_Expectancy = lifeExp, GDP = gdpPercap)


## Now join function


# Load the data set


client <- read.csv("Data/clients.csv")
orders <- read.csv("Data/orders.csv")


## Start joining the data set

names(client)
dim(client) # 20 14

dim(orders) # 80 25

names(orders)

# Now Left join

left_join(client,orders,by = "num_client") %>% dim()

right_join(client,orders, by = c("num_client" = "num_client")) %>% dim()

inner_join(client,orders, by = c("num_client" = "num_client")) %>% dim()

semi_join(client,orders, by = c("num_client" = "num_client")) %>% dim()

full_join(client,orders, by = c("num_client" = "num_client")) %>% dim()

anti_join(client,orders, by = c("num_client" = "num_client")) %>% dim()

### Use gapminder data to apply pivot widr and pivot longer
library(tidyr)
gapminder %>%
  select(-lifeExp,-gdpPercap) %>%
  pivot_wider(names_from = "year",
              values_from = "pop") -> wide_data

wide_data %>%
  pivot_longer(cols = names(wide_data)[3:14],
               names_to = "year",
               values_to = "pop")



