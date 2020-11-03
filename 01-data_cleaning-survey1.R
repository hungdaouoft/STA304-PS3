#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(vote_2020,
         age,
         race = race_ethnicity)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_data<-
  reduced_data %>%
  mutate(vote_trump = ifelse(vote_2020=="Donald Trump", 1, 0)) %>%
  filter(vote_2020 != 'I would not vote') %>%
  filter(vote_2020 != 'I am not sure/don\'t know')
  

table(reduced_data$vote_2020)



table(reduced_data$race)


reduced_data$race <- ifelse(reduced_data$race == 'White', 'white',
                                   ifelse(reduced_data$race== 'Black, or African American', 'black/african american',
                                          ifelse(reduced_data$race == 'American Indian or Alaska Native', 'american indian or alaska native', 
                                                 ifelse(reduced_data$race =='Asian (Chinese)', 'chinese',
                                                        ifelse(reduced_data$race =='Asian (Japanese)', 'japanese', 
                                                               ifelse(reduced_data$race == 'Some other race', 'other race', 'other asian or pacific islander'))))))


# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "survey_data.csv")

