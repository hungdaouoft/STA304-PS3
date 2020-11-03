#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
setwd("C:/Users/Sammi-Jo/Desktop/PS3")
raw_data <- read_dta("usa_00001.dta.gz")


# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- 
  raw_data %>% 
  select(sex, age, race)


# Add the labels
reduced_data <- labelled::to_factor(reduced_data)

table(reduced_data$race)

reduced_data <- reduced_data %>%
  filter(race != 'two major races') %>%
  filter(race != 'three or more major races')



reduced_data$race <- ifelse(reduced_data$race == 'white', 'white', ifelse(reduced_data$race =='black/african american/negro', 'black/african american',
                                                                                              ifelse(reduced_data$race =='american indian or alaska native', 'american indian or alaska native', 
                                                                                                     ifelse(reduced_data$race =='chinese', 'chinese', 
                                                                                                            ifelse(reduced_data$race =='japanese', 'japanese',
                                                                                                                   ifelse(reduced_data$race =='other asian or pacific islander', 'other asian or pacific islander',
                                                                                                                          'other race'))))))
         

#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_data <- 
  reduced_data %>%
  count(age, race) %>%
  group_by(age) 

reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "census_data.csv")



         