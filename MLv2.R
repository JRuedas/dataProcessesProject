library("tidyr")
library("caret")

library(ggplot2)
library(dplyr)
library(moments)
library(gridExtra)
library(tseries)
library(ppcor)
library(corrgram)
library(corrplot)
library(mvoutlier)
library(ppcor)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(lubridate)
library(data.table)
library(GGally)
library(ggpubr)
library(naniar)
library(mice) #treatment of missing values
library(missForest) #for prodNA
library(reshape2)
library(scales)

setwd("~/dataProcessesProject/")

madrid_2010 <-read.csv("dataWoNa/madrid_2010.csv")
madrid_2011 <-read.csv("dataWoNa/madrid_2011.csv")
madrid_2012 <-read.csv("dataWoNa/madrid_2012.csv")
madrid_2013 <-read.csv("dataWoNa/madrid_2013.csv")
madrid_2014 <-read.csv("dataWoNa/madrid_2014.csv")
madrid_2015 <-read.csv("dataWoNa/madrid_2015.csv")
madrid_2016 <-read.csv("dataWoNa/madrid_2016.csv")
madrid_2017 <-read.csv("dataWoNa/madrid_2017.csv")
madrid_2018 <-read.csv("dataWoNa/madrid_2018.csv")


#Insert column only_day
madrid_2010$only_day <-unlist(lapply(madrid_2010$date, day))
madrid_2011$only_day <-unlist(lapply(madrid_2011$date, day))
madrid_2012$only_day <-unlist(lapply(madrid_2012$date, day))
madrid_2013$only_day <-unlist(lapply(madrid_2013$date, day))
madrid_2014$only_day <-unlist(lapply(madrid_2014$date, day))
madrid_2015$only_day <-unlist(lapply(madrid_2015$date, day))
madrid_2016$only_day <-unlist(lapply(madrid_2016$date, day))
madrid_2017$only_day <-unlist(lapply(madrid_2017$date, day))
madrid_2018$only_day <-unlist(lapply(madrid_2018$date, day))


#Select Co, day, month, year, station
#Select optimal features for ourmodel
madrid_2010 <- dplyr::select(madrid_2010, CO, only_day, only_month, only_year, station)
madrid_2011 <- dplyr::select(madrid_2011, CO, only_day, only_month, only_year, station)
madrid_2011 <- dplyr::select(madrid_2011, CO, only_day, only_month, only_year, station)
madrid_2012 <- dplyr::select(madrid_2012, CO, only_day, only_month, only_year, station)
madrid_2013 <- dplyr::select(madrid_2013, CO, only_day, only_month, only_year, station)
madrid_2014 <- dplyr::select(madrid_2014, CO, only_day, only_month, only_year, station)
madrid_2015 <- dplyr::select(madrid_2015, CO, only_day, only_month, only_year, station)
madrid_2016 <- dplyr::select(madrid_2016, CO, only_day, only_month, only_year, station)
madrid_2017 <- dplyr::select(madrid_2017, CO, only_day, only_month, only_year, station)
madrid_2018 <- dplyr::select(madrid_2018, CO, only_day, only_month, only_year, station)


#Inner_join between years to insert C0_year_before
madrid_11_10 <- dplyr::inner_join(madrid_2011, madrid_2010, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_12_11 <- dplyr::inner_join(madrid_2012, madrid_2011, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_13_12 <- dplyr::inner_join(madrid_2013, madrid_2012, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_14_13 <- dplyr::inner_join(madrid_2014, madrid_2013, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_15_14 <- dplyr::inner_join(madrid_2015, madrid_2014, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_16_15 <- dplyr::inner_join(madrid_2016, madrid_2015, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_17_16 <- dplyr::inner_join(madrid_2017, madrid_2016, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_18_17 <- dplyr::inner_join(madrid_2018, madrid_2017, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))

#Merge all the information
madrid_list <- list(madrid_11_10, madrid_12_11, madrid_13_12, madrid_14_13, madrid_15_14, madrid_16_15, madrid_17_16, madrid_18_17)
madrid_list <- as.data.frame(rbindlist(madrid_list, fill = T))
madrid_list <- drop_na(madrid_list)

madrid_list <- dplyr::select(madrid_list, -only_year_year_before)
madrid_list$station <- as.factor(madrid_list$station)


#Summary
nrow(madrid_list)
dim(madrid_list)
summary(madrid_list)


#train and test
# Create a set of training indices
#36412969 registros
#lo ideal es coger una muestra del 0.7 o del 0.8 de elemenots aleatorios, 
#train_madrid_index <- createDataPartition(madrid_list,
#                                  p = .7,
#                                  list = FALSE,
#                                  times = 1
#)

# Subset your data into training and testing set
#training_set <- cancer[ trainIndex, ]
#test_set <- cancer[ -trainIndex, ]

#Split our data into:
#Training data: to build our model
#Testing data: to assess our model
training_set <- madrid_list[1:100000, ]
test_set <- madrid_list[100001:130000, ]


# Train, specifying cross validation
fitControl <- trainControl(
  method = "cv",
  number = 2
  )


#Linear Regression
lm_mod = train(
  CO ~ .,
  data = training_set,
  method = "lm",
  trControl = fitControl,
)


#k-Nearest Neighbors  
knn_mod = train(
  CO ~ .,
  data = training_set,
  method = "knn",
  trControl = fitControl,
)


#Validation
#Assess the accuracy of your predictions
preds_lm_mod <- predict(lm_mod, test_set)
preds_knn_mod <- predict(knn_mod, test_set)


#The RMSE corresponds to the square root of the average difference between the observed known outcome values and the predicted values
#The lower the RMSE, the better the model.
# Compute the prediction error RMSE
RMSE(preds_lm_mod, test_set$CO)
RMSE(preds_knn_mod, test_set$CO)

#We have the model, so we can use it to predict 2019 CO levels
# First of all, let's prepare the input data from the 2018 levels
madrid_19_18 <- madrid_18_17
madrid_19_18$CO_year_before <- madrid_18_17$CO
madrid_19_18$only_year <- 2018
madrid_19_18$station <- as.factor(madrid_18_17$station)
madrid_19_18 <- dplyr::select(madrid_19_18, -only_year_year_before)
head(madrid_19_18)
nrow(madrid_19_18)

madrid_19_18 <- madrid_19_18 %>%
  group_by(only_day, only_month, only_year, station) %>%
  summarise(CO_year_before = mean(CO_year_before))

madrid_19_18$CO <- 1
head(madrid_19_18)
nrow(madrid_19_18)

#We apply lm model
preds_lm_mod_2019 <- predict(lm_mod, madrid_19_18)
preds_lm_mod_2019 <- as.data.frame(preds_lm_mod_2019)
colnames(preds_lm_mod_2019)

#We apply knn model
preds_knn_mod_2019 <- predict(knn_mod, madrid_19_18)
preds_knn_mod_2019 <- as.data.frame(preds_knn_mod_2019)


#Insert the results give from knn model in 2019
madrid_19_18$CO <- preds_lm_mod_2019

head(madrid_19_18)

mean_madrid_19_18 <- madrid_19_18 %>%
  group_by(station) %>%
  summarise(CO_mean = mean(CO))

mean_madrid_19_18
summary(mean_madrid_19_18)

#visualizamos los resultados para 2019 según el modelo knn
ggplot(data = mean_madrid_19_18, mapping = aes(mean_madrid_19_18$station, y = mean_madrid_19_18$CO_mean)) +
  geom_bar(stat = "identity") +
  ggtitle("CO prediction Madrid 2019") +
  labs(x = "Station", y = "CO levels mean")





