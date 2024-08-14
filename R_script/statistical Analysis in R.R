## One sample t test

dat <- read.table("Data/tips_text.txt", header = T, sep = "\t")
head(dat)

# Hypothesis

H0 <- "The average tip is equal to 2.5 $"
H1 <- "The average tip is significantly different from the 2.5 $"

# Test for normality
hist(dat$tip)

shapiro.test(dat$tip)

# perform one sample t test
ost <- t.test(dat$tip, 
              alternative = "two.sided",
              mu = 2.5)
ost
# extract p value

p_value <- ost$p.value
p_value

# Decision

ifelse(p_value < 0.05, H1, H0)

# visualize the result

hist(dat$tip, main = "Distribution of tips", xlab = "Tips Amount",ylab = "frequency")
abline(v = ost$conf.int, col = "red", lwd = 2)
abline(v = 2.5, col = "blue", lwd = 2)

## two sample t test

var_test <- ansari.test(tip~sex,data = dat)
var_test

# Set up hypothesis

# do it your self

# perform two sample t test

tst <- t.test(tip ~ sex, data = dat, var.equal = TRUE)
tst


p_value <- tst$p.value
p_value

# decision

ifelse(p_value < 0.05, "Not equal","Equal")

library(ggplot2)
library(dplyr)
dat %>%
  ggplot(aes(x = sex, y = tip)) +
  geom_boxplot() +
  annotate(geom = "text",
           x = 1, y = 9,
           label = paste("P value = ",round(p_value,2)))

## paired t test

library(UsingR)
head(father.son)

# perform paired t test

paired <- t.test(father.son$fheight, father.son$sheight, paired = TRUE)
paired

p_value <- paired$p.value

# decision

ifelse(p_value < 0.05, "not equal", "equal")

father.son
library(tidyr)
data <- father.son %>%
  pivot_longer(cols = c("fheight","sheight"),
               names_to = "group",
               values_to = "height")
data

data %>%
  ggplot(aes(x = group, y = height)) +
  geom_boxplot() +
  annotate(geom = "text",
           x = 1,
           y = 80,
           label = paste("P Value = ", round(p_value,3)))

library(ggstatsplot)
ggbetweenstats(data = data,
               x = group,
               y = height,
               type = "p")

## ANOVA

## 3 or more groups 
pacman::p_load(ggplot2,ggpubr,tidyverse,broom,AICcmodavg)

crop_data <- read.csv("Data/crop.data.csv")
head(crop_data)
str(crop_data)

crop_data$density <- as.character(crop_data$density)
crop_data$fertilizer <- as.character(crop_data$fertilizer)
crop_data$block <- as.character(crop_data$block)

str(crop_data)

## effect of fertilizer in yield

# setting up hypothesis

H0 <- "No effect of fertilizer"
H1 <- "Significant effect of fertilizer"

## perform ANOVA

owa <- aov(yield ~ fertilizer, data = crop_data)
anova1 <- summary(owa)

anova_table <- as.data.frame(anova1[[1]])
anova_table

p_value <- anova1[[1]]$`Pr(>F)`[1]
p_value

# decision
ifelse(p_value < 0.05 , H1, H0)

## two way anova

## effects of fertilizer and density

h0_fert <- "no effect of fetilizer"
h1_fert <- "significant effect if fertilizer"


h0_dens <- "no effect of density"
h1_dens <- "significant effect of density"


# perform two way anova

twa <- aov(yield ~ fertilizer + density, data = crop_data)
anova2 <- summary(twa)

anova_table2 <- as.data.frame(anova2[[1]])
anova_table2

p_val_fert <- anova2[[1]]$`Pr(>F)`[1]
p_val_dens <- anova2[[1]]$`Pr(>F)`[2]

# decision fro density

ifelse(p_val_dens < 0.05, h1_dens, h0_dens)

## three way anova

thwa <- aov(yield ~ fertilizer + density + block, data = crop_data)
anova3 <- summary(thwa)

anova3

# interaction model

inter <- aov(yield ~ fertilizer * density, data = crop_data)
anova_int <- summary(inter)

model.set <- list(owa,twa,thwa,inter)
model.names <- c("One way", "Two way","Three way","Interaction")

aictab(model.set,modnames = model.names)

# post hoc analysis

summary(twa)

# post hoc analysis of anova is tukeyhsd tests
ph_twa <- TukeyHSD(twa)
ph_twa

library(dplyr)
crop_data %>%
  group_by(fertilizer) %>%
  summarise(n = n(),
            mean = mean(yield))-> summary_crop
summary_crop


library(ggstatsplot)
ggbetweenstats(data = crop_data,
               x = density,
               y = yield,
               type = 'p')

## Non parametric tests

# alternative of one sample t test

# wilcox test

np_ost <- wilcox.test(dat$tip, mu =2.5, conf.int = TRUE)
np_ost

# alternative of two sample t test

# Mann- Whitney test

np_tst <- wilcox.test(tip~sex, data = dat)
np_tst

## Alternative of paired t test

## wilcoxon matched paired test
np_paired <- wilcox.test(father.son$fheight, 
                         father.son$sheight, 
                         paired = TRUE, 
                         alternative = "two.sided")
np_paired


# alternative of anova
# kruskal wallis test

np_twa <- kruskal.test(yield ~ fertilizer, data = crop_data)
np_twa

# post hoc analysis

# dunn test

library(dunn.test)

ph_kw <- dunn.test(crop_data$yield, crop_data$fertilizer)


# Correlation tests

mtcars
head(mtcars)

r <- cor.test(mtcars$mpg, mtcars$wt, method= "pearson")
r

# simple visualtization

plot(mtcars$mpg, mtcars$wt)

library(psych)

pairs.panels(mtcars[,3:7],smooth = TRUE,hist.col = "pink")

## Visualize and correlation matrix

library(corrplot)
library(correlation)
library(Hmisc)
cor_mat <- rcorr(as.matrix(mtcars), type = "pearson")
cor_mat

correlation_matrix <- cor_mat$r
p_mat <- cor_mat$P

## visualize

corrplot(correlation_matrix, 
         method = "color", 
         type = "upper",
         tl.col = "black",
         tl.srt = 45)


corrplot.mixed(correlation_matrix,
               lower = "number",
               tl.col = "black",
               number.cex = 0.7)

corrplot(correlation_matrix,
         method = "color",
         type = "upper",
         order = "hclust",
         addCoef.col = "black",
         tl.col = "black",
         p.mat = p_mat,
         sig.level = 0.05,
         number.cex = 0.7)

## Regression
# simple linear regression

pacman::p_load(ggplot2,dplyr,broom,ggpubr,easystats,caret)

income <- read.csv("Data/income.data.csv")

head(income)

# Assumptions

## independency

## linearity
cor.test(income$income, income$happiness)
plot(income$income, income$happiness)

# normality of dependent variable

hist(income$happiness)

# homoscedasticity

# after the model development matra thaha hunchha


# model development

mod1 <-lm(happiness ~ income, data = income)
summary(mod1)

eqn <- paste0("H = ",0.71383 ," * I + ", 0.20427)
eqn
par(mfrow = c(2,2))
plot(mod1)
par(mfrow = c(1,1))

r_square <- paste0("R2 = ",round(as.numeric(r2(mod1)[[2]]),3))

error <- paste0("RMSE = ",round(rmse(mod1),2))

# visualize

ggplot(data = income,
       aes(x = happiness, y = predicted_happiness)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  annotate(geom = "text",
           x = 3,
           y = 7,
           label = eqn)+
  annotate(geom = "text",
           x = 3,
           y = 6.5,
           label = r_square) +
  annotate(geom = "text",
           x = 3,
           y = 6,
           label = error) +
  labs(x = "Income ($)",
       y = "Happiness",
       caption = "Source: Data source,2022")+
  theme_minimal()
## predict

income$predicted_happiness <- predict(mod1, newdata = income)
head(income)

### multiple Linear Regression

# assumptions
## in-dependency
## normality of dependent variable
heart <- read.csv("Data/heart.data.csv")

hist(heart$heart.disease)

## linearity

psych::pairs.panels(heart[,2:4])

## homoscedasticity : after model building

mlm <- lm(heart.disease ~ smoking + biking, 
          data = heart)

par(mfrow = c(2,2))
plot(mlm)
par(mfrow = c(1,1))

## 
library(easystats)
performance(mlm)

sum <- summary(mlm)
r_square <- paste0("R2 = ",round(sum$adj.r.squared,3))

error <- paste0("RMSE = ", round(rmse(mlm),3))

a <- round(sum$coefficients[2,1],3)

b <- round(sum$coefficients[3,1],3)

c <- round(sum$coefficients[1,1],3)

eqn <- paste0("HD = ",a," * smoking + ","(",b,")"," * biking + ", c)

# 
report(mlm)

# visualization

heart$p_diseases <- predict(mlm, newdata = heart)

library(dplyr)
library(ggplot2)

heart %>%
  ggplot(mapping = aes(x = heart.disease, y = p_diseases)) +
  geom_point(color = "blue") +
  geom_smooth(color = "red",method = "lm")+
  annotate(geom = "text",x = 10, y = 20,label = eqn)+
  annotate(geom = "text", x = 10, y = 18,label = r_square)+
  annotate(geom = "text", x = 10, y = 16, label = error) +
  labs(x = "Heart Diseases",
       y = "Predcited Heart Diseases")+
  theme_light()



