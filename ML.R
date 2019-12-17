library("tidyr")
library("caret")

library(ggplot2)
library(dplyr)
library(moments)
library(gridExtra)
library(tseries)
library(ppcor)
library(corrgram)
#library(car)
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

setwd("D:/Dropbox/Data/UPM/1.DP/Project/Project")
madrid_2010 <-read.csv("dataWoNa/madrid_2010.csv")
madrid_2011 <-read.csv("dataWoNa/madrid_2011.csv")
madrid_2012 <-read.csv("dataWoNa/madrid_2012.csv")
madrid_2013 <-read.csv("dataWoNa/madrid_2013.csv")
madrid_2014 <-read.csv("dataWoNa/madrid_2014.csv")
madrid_2015 <-read.csv("dataWoNa/madrid_2015.csv")
madrid_2016 <-read.csv("dataWoNa/madrid_2016.csv")
madrid_2017 <-read.csv("dataWoNa/madrid_2017.csv")
madrid_2018 <-read.csv("dataWoNa/madrid_2018.csv")

#Insert day
madrid_2010$only_day <-unlist(lapply(madrid_2010$date, day))
madrid_2011$only_day <-unlist(lapply(madrid_2011$date, day))
madrid_2012$only_day <-unlist(lapply(madrid_2012$date, day))
madrid_2013$only_day <-unlist(lapply(madrid_2013$date, day))
madrid_2014$only_day <-unlist(lapply(madrid_2014$date, day))
madrid_2015$only_day <-unlist(lapply(madrid_2015$date, day))
madrid_2016$only_day <-unlist(lapply(madrid_2016$date, day))
madrid_2017$only_day <-unlist(lapply(madrid_2017$date, day))
madrid_2018$only_day <-unlist(lapply(madrid_2018$date, day))


#Select Co, day, month, year
#Insert year_before #no haría falta 
#madrid_2010 <- dplyr::select(madrid_2010, CO, only_day, only_month, only_year) %>% mutate(year_before = only_year - 1)
colnames(madrid_2010)
#Select optimal features for your model
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

#join between years to insert C0_year_before
#Generate features from existing columns
#inner_join to avoid na
madrid_11_10 <- dplyr::inner_join(madrid_2011, madrid_2010, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"), )
madrid_12_11 <- dplyr::inner_join(madrid_2012, madrid_2011, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_13_12 <- dplyr::inner_join(madrid_2013, madrid_2012, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_14_13 <- dplyr::inner_join(madrid_2014, madrid_2013, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_15_14 <- dplyr::inner_join(madrid_2015, madrid_2014, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_16_15 <- dplyr::inner_join(madrid_2016, madrid_2015, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_17_16 <- dplyr::inner_join(madrid_2017, madrid_2016, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))
madrid_18_17 <- dplyr::inner_join(madrid_2018, madrid_2017, by = c("only_day", "only_month", "station"), suffix = c("", "_year_before"))

#join all the information

madrid_list <- list(madrid_11_10, madrid_12_11, madrid_13_12, madrid_14_13, madrid_15_14, madrid_16_15, madrid_17_16, madrid_18_17)
madrid_list <- as.data.frame(rbindlist(madrid_list, fill = T))
madrid_list <- drop_na(madrid_list)

madrid_list <- dplyr::select(madrid_list, -only_year_year_before)
madrid_list$station <- as.factor(madrid_list$station)


#train and test
# Create a set of training indices
#train_madrid_list <- createDataPartition(madrid_11_10,
#                                  p = .8,
#                                  list = FALSE,
#                                  times = 1
#)

# Subset your data into training and testing set
#training_set <- cancer[ trainIndex, ]
#test_set <- cancer[ -trainIndex, ]
#Split our data into:
#Training data: to build our model
#Testing data: to assess our model

training_set <- madrid_list[1:50000, ]
test_set <- madrid_list[50000:60000, ]
nrow(madrid_list)
colnames(training_set)
colnames(test_set)
nrow(training_set)
nrow(test_set)
summary(training_set)
summary(test_set)

#supervised know the correct answer (outcome)
#Develop a model that can accurately predict the outcome based on data features
#nuestro problema es de regresion
#creating training and testing data
#Methods:
# Linear regression
#decision trees not very suiteable for us aunque también vale para regresion
#K Nearest Neighbors

#Model implementation
#Train an algorithm (model) on your data
#Tune the parameters of that model 
#numbers of trees an k in knn


# Train, specifying cross validation
fitControl <- trainControl(
  method = "cv",
  number = 2
  )

# Create a grid of parameters to search through (values for k, 1:20)
grid <- expand.grid(k = 1:5)

#Linear Regression
lm_mod = train(
  CO ~ .,
  data = training_set,
  method = "lm",
  trControl = fitControl,
  # preProcess = c("center", "scale"),
  #tuneGrid = grid
)

#Model Tree segunda vuelta
m5_mod = train(
  CO ~ .,
  data = training_set,
  method = "blackboost",
  trControl = fitControl,
  # preProcess = c("center", "scale"),
  #tuneGrid = grid
)

#k-Nearest Neighbors  
knn_mod = train(
  CO ~ .,
  data = training_set,
  method = "knn",
  trControl = fitControl,
  # preProcess = c("center", "scale"),
  tuneGrid = grid
)



#https://daviddalpiaz.github.io/r4sl/the-caret-package.html
#https://github.com/data-processes-upm/machine_learning/blob/solution/analysis.R
#https://topepo.github.io/caret/available-models.html 
#https://www.rdocumentation.org/packages/caret/versions/4.47/topics/train
#https://www.dataquest.io/blog/statistical-learning-for-predictive-modeling-r/
#http://www.sthda.com/english/articles/35-statistical-machine-learning-essentials/142-knn-k-nearest-neighbors-essentials/
#https://www.machinelearningplus.com/machine-learning/complete-introduction-linear-regression-r/


#Validation
#Assess the accuracy of your predictions
preds_lm_mod <- predict(lm_mod, test_set)
preds_knn_mod <- predict(knn_mod, test_set)

#The best k is the one that minimize the prediction error RMSE (root mean squared error).
#The RMSE corresponds to the square root of the average difference between the observed known outcome values and the predicted values, RMSE = mean((observeds - predicteds)^2) %>% sqrt(). The lower the RMSE, the better the model.
# Compute the prediction error RMSE
RMSE(preds_lm_mod, test_set$CO)
RMSE(preds_knn_mod, test_set$CO)

plot(knn_mod)

#confusion matrix no aplica, es para classification
confusionMatrix(test_set$CO, preds_lm_mod)

summary(lm_mod)
summary(knn_mod)



#hay que hacer un gráfico
#por cada estación, group by year, mean de CO
#por cada estación, group by year, month, mean de CO

#hay que hacer un gráfico para los últimos 10 años
#group by station, mean de CO

