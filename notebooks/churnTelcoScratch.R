# vis
#library('ggplot2') # visualization
library('ggthemes') # visualization
library('ggridges') # visualization
library('ggforce') # visualization
library('ggExtra') # visualization
library('GGally') # visualisation
library('scales') # visualization
library('grid') # visualisation
library('gridExtra') # visualisation
library(corrplot) # visualisation
library('ggalluvial') # visualisation
library(VIM) # missing values
#suppressPackageStartupMessages(library(heatmaply)) # visualisation

# wrangle
library(tidyverse)
#library('dplyr') # data manipulation
#library('tidyr') # data manipulation
#library('readr') # data input
#library('stringr') # string manipulation
#library('forcats') # factor manipulation
library(modelr) # factor manipulation
library(skimr) # data exploration

# model
library(randomForest) # classification
library(xgboost) # classification
library(ROCR) # model validation

# dataframe
churn.df <- read.csv('https://raw.githubusercontent.com/jotsap/DS7331/master/data/churn.csv')

str(churn.df)
head(churn.df)

# make FACTOR flavor of SeniorCitizen column
churn.df <- churn.df %>% mutate(
  SeniorCitizenFactor = factor(SeniorCitizen)
)


# NOTE: can create bins for numeric variables later

### OVERVIEW OF DATA SET ###

str(churn.df)

# EXPLORE DATA

summary(churn.df)
glimpse(churn.df)

skim(churn.df)
# 7043 rows in the data set
# ratio of M to F is fairly even: 3555 M vs 3488 F








### MISSING DATA ###

# from VIM package
library(VIM)
aggr(churn.df, 
     prop = FALSE, 
     combined = TRUE, 
     numbers = TRUE, 
     sortVars = TRUE, 
     sortCombs = TRUE)

# we can see that 'TotalCharges' has 11 missing values

# VALIDATE COUNT OF NA VALUES FOR ABOVE ROWS
sum(is.na(churn.df$TotalCharges))


# GET RATIO OF YES / NO FOR CHURN FACTOR RESPONSE
churn.df %>% count(Churn)




### VISUALIZATION ###



# LINEAR GRAPH
ggplot(train) +
  geom_freqpoly(mapping = aes(x = DAYS_LIFE, color = CHURN_FACTOR), binwidth = 1) +
  guides(fill=FALSE) +
  theme(legend.position = "none")


# CATEGORICAL GRAPH
ggplot(train, mapping = aes(x = DEVICE_FACTOR, fill = CHURN_FACTOR, color = CHURN_FACTOR)) +
  geom_bar(stat='count', position='fill') +
  labs(x = 'DEVICE_FACTOR') +
  theme(legend.position = "none")







###### FILLING IN MISSING VALUES ######

# Start by grouping columns with missing data by CHURN

### STATE_DATA ###

# MEDIAN for TotalCharges
churn.df %>%
  group_by(Churn) %>%
  summarize(MedianTotalCharges = median(TotalCharges, na.rm=TRUE))
# median for Churn No = 1684
# median for Churn Yes = 704

# MEAN for TotalCharges
churn.df %>%
  group_by(Churn) %>%
  summarize(MeanTotalCharges = mean(TotalCharges, na.rm=TRUE))
# mean for Churn No = 2555
# mean for Churn Yes = 1532




# PhoneService grouped by Churn and Gender
churn.df %>% group_by(Churn, gender) %>% count(PhoneService)

#  Churn gender PhoneService     n
#1 No    Female No             251
#2 No    Female Yes           2298
#3 No    Male   No             261
#4 No    Male   Yes           2364
#5 Yes   Female No              80
#6 Yes   Female Yes            859
#7 Yes   Male   No              90
#8 Yes   Male   Yes            840





