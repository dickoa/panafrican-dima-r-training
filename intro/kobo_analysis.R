# Installing + loading packages
install.packages("remotes")
remotes::install_gitlab("dickoa/robotoolbox")
library(robotoolbox)

install.packages("usethis")
library(usethis)

usethis::edit_r_environ()

# Connecting to API token
kobo_setup(url = "https://kobo.unhcr.org",
           token = "e16690e31f1ff474dec9faf71619ee8f558e0508")

# List of all forms
l <- kobo_asset_list()
glimpse(l)

# Filtering specific forms
uid <- l %>%
  filter(name == "Pan-African Capacity Building in R") |>
  pull(uid) %>%
  first()
uid

asset <- kobo_asset(uid)
asset

df <- kobo_submissions(asset)
glimpse(df)

# New column concatenating Regional Bureau and Country Operations
install.packages("tidyverse")
library(tidyverse)

df$where = df$ops
df$where[!is.na(df$bureau)] = df$bureau[!is.na(df$bureau)]
df$where[!is.na(df$mco)] = df$mco[!is.na(df$mco)]

# Visualizing the data.frame content
install.packages("formattable")
library(formattable)
formattable(df)

# Creating a graph
install.packages("remotes")
remotes::install_github("vidonne/unhcrthemes")
library(unhcrthemes)
library(ggplot2)

  ggplot(subset(df, !is.na(where)),
         aes(x = fct_infreq(where))) +
    geom_bar(fill = unhcr_pal(n = 1, "pal_blue")) +
    labs(title = "Where are you based?")