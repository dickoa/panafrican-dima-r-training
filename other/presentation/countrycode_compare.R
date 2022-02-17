library(readr)
library(readxl)
library(tidyverse)
#------------------
library(countrycode)



# compare dataport and popdata country names

dataport <- readr::read_csv(here("other", "data", "dataport_poc.csv")) # unhcr code
asr <- readr::read_csv(here("other", "data", "asr_demographics.csv")) # iso code

asr <-
  asr %>% filter(year == 2020) %>%
  group_by(origin_iso, origin_name) %>%
  summarise(popdata_value = sum(total))

names(dataport) <- c("dataport_coo_code", "dataport_coo_name", "dataport_value")
names(asr) <- c("asr_coo_code", "asr_coo_name", "asr_value_2020")

# country list
country_list <- read_xlsx(here("other", "data", "unhcr_country_region.xlsx"), skip = 3)

# add iso3 to dataport code
dataport <-
  dataport %>%
  mutate(iso3 = countrycode(dataport_coo_code, origin = "unhcr", destination = "iso3c"))

# add country name of asr data
dataport <-
  dataport %>%
  left_join(asr, by = c("iso3" = "asr_coo_code"))


####
names(country_list) <- c("iso3", "unhcr", "unsd_name", "unsd_short_asylum",
                          "unsd_short_origin", "unhcr_region", "unsd_region",
                          "unsd_subregion", "sdg_region", "iso3_2")

