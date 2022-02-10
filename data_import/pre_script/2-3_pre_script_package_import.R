####### PanAfrica R training
####### 15 Feb 2022
####### 2. Recap of packages

############################################################################
#install.packages(c("tidyverse", "readxl", "writexl", "haven", "pdftools", "here"), 
#                 repos = "https://cloud.r-project.org/") # specifying repository to read the data of packages

# let R know that the packages are needed
library(tidyverse)
library(readxl)
library(writexl)
library(haven)
library(pdftools)
library(here)

####### 3. Import and export of data

############################################################################
##### Working directory

here() # check the current working directory
setwd("~/UNHCR")

############################################################################
##### Import data

##### csv: Refugee data of ASR 2020

asr <- read_csv2(here("data_import", "data", "asr-refugees-2021.csv")) # tidyverse package
head(asr)
names(asr)                

############################################################################
##### Stata: Survey data, Understanding the socioeconomic conditions of refugees in Kalobeyei, Kenya 2018

survey <- read_dta(here("data_import", "data", "ken-sesurvey-2018-edu.dta")) # haven package

head(survey)
names(survey)  

############################################################################
##### excel: Resettlement data

rst <- read_xls(here("data_import", "data", "rst-sa-summary-dep-202112.xls"),
                skip = 5, col_names = FALSE) # readxl package

# cleaning column names
rst_name <- paste(rst[1, ], rst[2, ], sep = "_")
rst_name <- gsub("NA_", "", rst_name)
names(rst) <- rst_name
# remove rows of names
rst <- rst %>% slice(3:n())

head(rst) # check the data frame

############################################################################
##### pdf: South Africa government data of PoCs

# Import the table
pdf <- pdf_text(here("data_import", "data", "zaf-asr-gov-2020-p25.pdf"))

pdf_clean <- strsplit(pdf, "\n") # split each line
pdf_clean <- pdf_clean[[1]] # keep only the first element
pdf_clean <- trimws(pdf_clean) # remove white space

pdf_clean <- pdf_clean[grep("Bangladesh", pdf_clean):
                         grep("TOTAL", pdf_clean)] # remove marginal areas

# install.packages("stringr")
library(stringr)

pdf_clean <- str_split_fixed(pdf_clean, " {2,}", 9) # split a row into different columns
pdf_clean <- data.frame(pdf_clean) %>% select(1:4) # clean redundant columns
names(pdf_clean) <- c("nationality", "dismissed", "upheld", "cancelled") # assign names to the data frame

head(pdf_clean) # check the data frame

############################################################################
##### Export

# excel
write_xlsx(pdf_clean, here("zaf-pdf.xlsx"))

# csv
write_csv(pdf_clean, here("zaf_pdf.csv"))

# Stata (.dta)
write_dta(rst, here("rst.dta"))

# SPSS (.sav)
write_sav(rst, here("rst.sav"))