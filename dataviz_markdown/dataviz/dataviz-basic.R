## Importing the dataset
library(unhcrthemes)
library(tidyverse)
data(idp, package = "unhcrthemes") ## loading the dataset available in the package

idp %>%
  ggplot()

## What's in the dataset?
glimpse(idp)
str(idp)
view(idp)
summary(idp)
idp

## Exploring data with basic graphs...
hist(idp$year)
plot(idp$year, idp$idp)
boxplot(idp$idp ~ idp$year)
barplot(idp$idp, idp$year)
barplot(idp$idp, names = idp$year)

## Good practice is to organize your data first!
idp_total <- idp %>%
  group_by(year) %>%
  summarize(idp = sum(idp, na.rm = TRUE) / 1e6) |>
  ungroup()

glimpse(idp_total)

barplot(idp_total$idp, idp_total$year)
barplot(idp_total$idp, names = idp_total$year)


## Moving to ggplot2 - why?
## https://github.com/tidyverse/ggplot2/wiki/Why-use-ggplot2

## Learning the syntax
ggplot(data = idp_total, aes(x = year, y = idp))

### By convention, our X axis is an independent variable, while Y is a dependent variable.
### So if we look as the number of idp as a function of time, we are analyzing the relationship between these two variables.

## geom_* there are more than 40 geometries available

#1
ggplot(data = idp_total, aes(x = year, y = idp)) +
  geom_point()

#2
ggplot(idp_total, aes(year, idp)) +
  geom_point() +
  geom_line()

# 3
ggplot(idp_total, aes(x = year, y = idp)) +
  geom_point(size = 5) +
  geom_line(color = "red")

# 4: Column chart
ggplot(data = idp_total, aes(x = year, y = idp)) +
  geom_col()

# 5: Fill
ggplot(data = idp, aes(x = year, y = idp, fill = sex)) +
  geom_col()

## Improving our visualization: applying unhcrthemes
# We could edit it manually...
ggplot(data = idp_total, aes(x = year, y = idp)) +
  geom_col(fill = "#0072BC")

# However, we have a package to help us with that!
library(unhcrthemes)
?unhcrthemes

display_unhcr_all()

# 1: using function unhcr_pal
ggplot(data = idp_total, aes(x = year, y = idp)) +
  geom_col(fill = unhcr_pal(n = 1, "pal_blue"))

# 2: changing it to green IDP
ggplot(data = idp_total, aes(x = year, y = idp)) +
  geom_col(fill = unhcr_pal(n = 1, "pal_green"))

# 3: Let's reverse engineer and fast-forward to an end result
ggplot(idp_total, aes(year, idp)) +
  geom_col(fill = unhcr_pal(n = 1, "pal_blue"),
           width = 0.8) + # Editing fonts
  labs(title = "Global IDP displacement | 2010 - 2020",
       y = "Number of people (in million)",
       caption = "Source: UNHCR Refugee Data Finder\n© UNHCR, The UN Refugee Agency") + # Editing labels
  scale_y_continuous(expand = expansion(c(0, 0.1))) +
  scale_x_continuous(breaks = pretty_breaks(10)) + # Editing scale of axis with pretty() function
  theme_unhcr(grid = "Y", axis_title = "y") # UNHCR Theme

# 4: Facet wraps
  ggplot(idp, aes(year, idp)) +
    geom_col(fill = unhcr_pal(n = 1, "pal_blue")) +
    labs(title = "Global IDP displacement by sex",
         y = "Number of people") +
    scale_x_continuous(breaks = pretty_breaks(10)) +
    scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
    facet_wrap(~ sex) 

# 5: Themes
  ggplot(idp, aes(year, idp)) +
    geom_col(fill = unhcr_pal(n = 1, "pal_blue")) +
    labs(title = "Global IDP displacement by sex",
         y = "Number of people") +
    scale_x_continuous(breaks = pretty_breaks(10)) +
    scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
    facet_wrap(~ sex) +
    theme_unhcr()

## Exploring themes...
?theme_unhcr

  ggplot(idp, aes(year, idp)) +
    geom_col(fill = unhcr_pal(n = 1, "pal_blue")) +
    labs(title = "Global IDP displacement by sex",
         y = "Number of people") +
    scale_x_continuous(breaks = pretty_breaks(10)) +
    scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
    facet_wrap(~ sex) +
    theme_unhcr(grid = "Y", axis_title = "y")

############################
### QUIZ