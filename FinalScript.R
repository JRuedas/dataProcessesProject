library(ggplot2)
library(dplyr)
library(moments)
library(gridExtra)
library(tseries)
library(ppcor)
library(corrgram)
library(car)
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
# Load CSVs
madrid_2010 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2010.csv")
madrid_2011 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2011.csv")
madrid_2012 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2012.csv")
madrid_2013 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2013.csv")
madrid_2014 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2014.csv")
madrid_2015 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2015.csv")
madrid_2016 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2016.csv")
madrid_2017 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2017.csv")
madrid_2018 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2018.csv")

station <- read.csv("data/Madrid_pollution_level_dataset/stations.csv")

# Group CSVs
madrid_list <- list(madrid_2010, madrid_2011, madrid_2012, madrid_2013,
                    madrid_2014, madrid_2015, madrid_2016, madrid_2017, madrid_2018)
madrid_18 <- as.data.frame(rbindlist(madrid_list, fill = T))

remove(madrid_2010)
remove(madrid_2011)
remove(madrid_2012)
remove(madrid_2013)
remove(madrid_2014)
remove(madrid_2015)
remove(madrid_2016)
remove(madrid_2017)
remove(madrid_2018)
remove(madrid_list)
# remove(madrid_18)

# Data Wrangling
madrid_final <- madrid_18[with(madrid_18, order(date)),]
madrid_final$only_month <-lapply(madrid_final$date, month)
madrid_final$only_year <-lapply(madrid_final$date, year)
madrid_final$date<-as.POSIXct(madrid_final$date,format = "%Y-%m-%d %H:%M:%S", tz='CET')

gg_miss_var(madrid_final, show_pct = T) #overall missing values
selected_features <- madrid_final %>%  
              dplyr::select("date", "only_year", "only_month","station", "CO", "O_3", "PM10", "NO_2", "SO_2")

madrid_final1 <- as.data.frame(lapply(selected_features, unlist))
madrid_final1$only_year <- as.factor(madrid_final1$only_year)
madrid_final1$only_month <- as.factor(madrid_final1$only_month)
madrid_final1$station <- as.factor(madrid_final1$station)

gg_miss_var(dplyr::select(madrid_final1, 4:8), show_pct = T) #missing values just for the 5 variables that we use

# Missing values:
madrid_final1$CO[is.na(madrid_final1$CO)] <- round(mean(madrid_final1$CO, na.rm = TRUE))
madrid_final1$O_3[is.na(madrid_final1$O_3)] <- round(mean(madrid_final1$O_3, na.rm = TRUE))
madrid_final1$PM10[is.na(madrid_final1$PM10)] <- round(mean(madrid_final1$PM10, na.rm = TRUE))
madrid_final1$NO_2[is.na(madrid_final1$NO_2)] <- round(mean(madrid_final1$NO_2, na.rm = TRUE))
madrid_final1$SO_2[is.na(madrid_final1$SO_2)] <- round(mean(madrid_final1$SO_2, na.rm = TRUE))