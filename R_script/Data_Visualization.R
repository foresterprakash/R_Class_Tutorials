dat <- read.table("Data/tips_text.txt", sep = "\t", header = TRUE)

names(dat)
str(dat)

# plot function in Base R
plot(dat$tip)

hist(dat$tip)

boxplot(dat$tip)

boxplot(tip~sex, data = dat,
        col = c("red","blue"),
        main = "My Figure",
        xlab = "Gender",
        ylab = "Tips in dollar")

barplot(table(dat$sex))

### Introduction to ggplot

library(ggplot2)

ggplot(data = dat,
       mapping = aes(x = total_bill, 
                     y = tip)) +
  geom_point(color = "blue",
             alpha = 1,
             size = 3,
             shape = "A")

## Grouping
library(dplyr)
dat %>%
  ggplot(mapping = aes(x = total_bill,
                       y = tip,
                       color = sex)) +
  geom_point() +
  scale_color_manual(values = c("red","blue"))+
  theme(legend.position = "top")

# Scales 
dat %>%
  ggplot(mapping =aes(x = total_bill,
                      y = tip,
                      color = sex))+
  geom_point()+
  scale_x_continuous(breaks = seq(0,60,5),
                     label = scales::dollar)+
  scale_y_continuous(breaks = seq(0,12,2),
                     label = scales::dollar)

# Smooth
dat %>% 
  ggplot(mapping = aes(x = total_bill,
                       y = tip,
                       color= sex))+
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~day) +
  labs(title = "My Figure",
       subtitle = "In class work",
       x = "Total Bill",
       y = "Tips",
       caption = "Source: Data Source")+
  theme_gray() -> my_plot

my_plot

# Uni variate Graph

## Categorical / Factor 

### Bar chart

library(mosaicData)
library(ggplot2)
library(dplyr)

str(Marriage)
names(Marriage)

Marriage %>%
  ggplot(mapping = aes(x = race,
                       y = after_stat(count))) +
  geom_bar(color = "black",
           fill = "lightblue")

# Now with percent

Marriage %>%
  ggplot(mapping = aes(x = race,
                       y = after_stat(count/sum(count))))+
  geom_bar(color = "black",
           fill = "lightblue")+
  scale_y_continuous(breaks = seq(0,1,0.1),
                     labels = scales::percent) +
  labs(x = "Race",
       y = "Percentage")

## Sorting and labeling requires the summary table

plot_dat <- Marriage %>%
  group_by(race) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  mutate(pct = n/sum(n)) %>%
  mutate(pct_n = paste0(round(pct * 100,2)," %"))

# create a bar plot from this new data

plot_dat %>%
  ggplot(mapping = aes(x = race, y = n))+
  geom_bar(stat = "identity")+
  geom_text(aes(label = n), 
            color = "red",
            vjust = -0.30) +
  lims(y = c(0,80))

# percent graph

plot_dat %>%
  ggplot(mapping = aes(x = reorder(race,-pct),
                       y = pct))+
  geom_bar(stat = "identity")+
  geom_text(aes(label = pct_n),
            vjust = -0.35)+
  lims(y = c(0,0.8)) 

# Bar plot with many levels 

Marriage %>%
  ggplot(mapping = aes(x = officialTitle))+
  geom_bar()

# Solution 1 is to flip the cord

Marriage %>%
  ggplot(mapping = aes(x = officialTitle))+
  geom_bar() +
  coord_flip()

# solution 2 is to angle the text

Marriage %>%
  ggplot(mapping = aes(x = officialTitle))+
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1))
# Uni-variate

# Categorical

# Pie chart
library(ggpie)

ggpie(
  diamonds,
  group_key = "cut",
  count_type = "full",
  fill_color = c("red","blue","yellow","pink","green"),
  label_info = "count",
  label_split = "[[:space:]]+",
  label_len = 40,
  label_color = "black",
  label_type = "horizon",
  label_pos = "out",
  label_gap = 0.05,
  label_threshold = NULL,
  label_size = 2,
  border_color = "black",
  border_size = 0.25,
  nudge_x = 1,
  nudge_y = 1
)


ggpie(
  Marriage,
  group_key = "race",
  count_type = "full",
  fill_color = c("red","blue","yellow","pink"),
  label_info = "count",
  label_split = "[[:space:]]+",
  label_len = 40,
  label_color = "black",
  label_type = "horizon",
  label_pos = "out",
  label_gap = 0.05,
  label_threshold = NULL,
  label_size = 3,
  border_color = "black",
  border_size = 1,
  nudge_x = 1,
  nudge_y = 1
)

# Uni variate 
# categorical

# Tree Map
library(treemapify)
library(dplyr)
library(ggplot2)
library(mosaicData)

plot_dat

plot_dat %>%
  ggplot(mapping = aes(fill = race,
                       area = n)) +
  geom_treemap() +
  theme(legend.position = "top")

plot_dat %>%
  ggplot(mapping = aes(fill = race,
                       area = n,
                       label = n)) +
  geom_treemap() +
  geom_treemap_text(color = "white",
                    place = "centre",
                    min.size = 2)+
  theme(legend.position = "bottom")

## Uni variate 
## Categorical 

## Waffle Chart
library(waffle)

plot_dat %>%
  ggplot(mapping = aes(fill = race, values = n)) +
  geom_waffle(na.rm = TRUE)


## Uni variate 
# Quantitative

# Histogram

Marriage %>%
  ggplot(mapping = aes(x = age))+
  geom_histogram(color = "black",
                 fill = "lightblue",
                 binwidth = 5)


## Density plot

Marriage %>%
  ggplot(mapping = aes(x = age)) +
  geom_density(color = "red",
               linetype = 1,
               linewidth = 1)

## Dot chart

Marriage %>%
  ggplot(mapping = aes(x = age))+
  geom_dotplot(color = "black",
               fill = "yellow",
               binwidth = 2)

# Bi-variate plots in both categorical and quantitative data


## Categorical vs categorical 

# Grouped bar chart 

library(ggplot2)
library(dplyr)

mpg
str(mpg)

mpg %>%
  ggplot(mapping = aes(x = class,
                       fill = drv)) +
  geom_bar(position = "stack")

mpg %>%
  ggplot(mapping = aes(x = class,
                       fill = drv)) +
  geom_bar(position = "dodge")

mpg %>%
  ggplot(mapping= aes(x = class,
                      fill = drv)) +
  geom_bar(position = position_dodge(preserve = "single"))

mpg %>%
  ggplot(mapping = aes(x = class,
                       fill = drv)) +
  geom_bar(position = "fill") +
  labs(y= "proportion")


##### 

plot_data <- mpg %>%
  group_by(class,drv) %>%
  summarise(n = n()) %>%
  mutate(pct = n/sum(n),
         lbl = scales::percent(pct))


plot_data %>%
  ggplot(aes(x = factor(class,
                        levels = c("2 seater",
                                   "subcompact",
                                   "compact",
                                   "midsize",
                                   "minivan",
                                   "suv",
                                   "pickup")),
             y = pct,
             fill = factor(drv,
                           levels = c("f","r","4"),
                           labels = c("Front Wheel",
                                      "Rear Wheel",
                                      "4WD")))) +
  geom_bar(stat = "identity",
           position = "fill") +
  labs(x = "Class",
       y = "Percentage",
       fill = "Drive Type") +
  geom_text(aes(label = lbl),
            size = 3,
            position = position_stack(vjust = 0.5)) 
#+
  #scale_fill_brewer(palette = 7)

## Bi-variate Categorical 

## Bi-variate quantitative vs quantitative data

## Line plot

library(gapminder)
gapminder

gapminder %>%
  ggplot(aes(x = year, y = pop/1000000)) +
  geom_line()

gapminder %>%
  filter(country == "Nepal") %>%
  ggplot(aes(x = year, y = pop/1000000))+
  geom_line(linetype = 1,
            linewidth = 1,
            color= "red")+
  geom_point(size = 3,
             color = "blue")+
  geom_text(aes(label = round(pop/1000000,2)),
            vjust = -1,
            hjust = 1)+
  labs(y = "population in million")

gapminder %>%
  filter(continent == "Americas") %>%
  ggplot(aes(x = year, y = pop/1000000))+
  geom_line(linetype = 1,
            linewidth = 1,
            color= "red")+
  geom_point(size = 3,
             color = "blue")+
  geom_text(aes(label = round(pop/1000000,2)),
            vjust = -1,
            hjust = 1)+
  labs(y = "population in million") +
  facet_wrap(~country)


library(carData)
library(tidyverse)
Salaries %>%
  ggplot(mapping = aes(x = salary, fill = rank))+
  geom_density(alpha = 0.5)

Salaries %>%
  ggplot(aes(x = rank, y = salary)) +
  geom_boxplot(color = "black",
               fill = c("red","green","yellow"))




  



  















