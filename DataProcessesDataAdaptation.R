library(tidyverse)
library(ggplot2)
library(dplyr)
library(lubridate)
library(data.table)
# Load CSVs
madrid_2010 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2010.csv")

madrid_2010$only_month <-unlist(lapply(madrid_2010$date, month))
madrid_2010$only_year <-unlist(lapply(madrid_2010$date, year))

means<-  madrid_2010 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2010 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2010$BEN)){
  if(is.na(madrid_2010$CO[i])){
    madrid_2010$CO[i]<-means$mean_CO[means$only_month==madrid_2010$only_month[i]&means$only_year==madrid_2010$only_year[i]&means$station==madrid_2010$station[i]]}
  if(is.na(madrid_2010$NO_2[i])){
    madrid_2010$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2010$only_month[i]&means$only_year==madrid_2010$only_year[i]&means$station==madrid_2010$station[i]]}
  if(is.na(madrid_2010$O_3[i])){
    madrid_2010$O_3[i]<-means$mean_O3[means$only_month==madrid_2010$only_month[i]&means$only_year==madrid_2010$only_year[i]&means$station==madrid_2010$station[i]]}
  if(is.na(madrid_2010$SO_2[i])){
    madrid_2010$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2010$only_month[i]&means$only_year==madrid_2010$only_year[i]&means$station==madrid_2010$station[i]]}
  if(is.na(madrid_2010$PM10[i])){
    madrid_2010$PM10[i]<-means$mean_PM10[means$only_month==madrid_2010$only_month[i]&means$only_year==madrid_2010$only_year[i]&means$station==madrid_2010$station[i]]}
  
}

for(i in 1:length(madrid_2010$BEN)){
  if(is.nan(madrid_2010$CO[i])){
    madrid_2010$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2010$only_month[i]&meansNoStation$only_year==madrid_2010$only_year[i]]}
  if(is.nan(madrid_2010$NO_2[i])){
    madrid_2010$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2010$only_month[i]&meansNoStation$only_year==madrid_2010$only_year[i]]}
  if(is.nan(madrid_2010$O_3[i])){
    madrid_2010$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2010$only_month[i]&meansNoStation$only_year==madrid_2010$only_year[i]]}
  if(is.nan(madrid_2010$SO_2[i])){
    madrid_2010$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2010$only_month[i]&meansNoStation$only_year==madrid_2010$only_year[i]]}
  if(is.nan(madrid_2010$PM10[i])){
    madrid_2010$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2010$only_month[i]&meansNoStation$only_year==madrid_2010$only_year[i]]}
  
}

write.csv(madrid_2010,"dataWoNa/madrid_2010.csv", row.names = TRUE)

madrid_2011 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2011.csv")

madrid_2011$only_month <-unlist(lapply(madrid_2011$date, month))
madrid_2011$only_year <-unlist(lapply(madrid_2011$date, year))

means<-  madrid_2011 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2011 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2011$BEN)){
  if(is.na(madrid_2011$CO[i])){
    madrid_2011$CO[i]<-means$mean_CO[means$only_month==madrid_2011$only_month[i]&means$only_year==madrid_2011$only_year[i]&means$station==madrid_2011$station[i]]}
  if(is.na(madrid_2011$NO_2[i])){
    madrid_2011$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2011$only_month[i]&means$only_year==madrid_2011$only_year[i]&means$station==madrid_2011$station[i]]}
  if(is.na(madrid_2011$O_3[i])){
    madrid_2011$O_3[i]<-means$mean_O3[means$only_month==madrid_2011$only_month[i]&means$only_year==madrid_2011$only_year[i]&means$station==madrid_2011$station[i]]}
  if(is.na(madrid_2011$SO_2[i])){
    madrid_2011$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2011$only_month[i]&means$only_year==madrid_2011$only_year[i]&means$station==madrid_2011$station[i]]}
  if(is.na(madrid_2011$PM10[i])){
    madrid_2011$PM10[i]<-means$mean_PM10[means$only_month==madrid_2011$only_month[i]&means$only_year==madrid_2011$only_year[i]&means$station==madrid_2011$station[i]]}
  
}

for(i in 1:length(madrid_2011$BEN)){
  if(is.nan(madrid_2011$CO[i])){
    madrid_2011$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2011$only_month[i]&meansNoStation$only_year==madrid_2011$only_year[i]]}
  if(is.nan(madrid_2011$NO_2[i])){
    madrid_2011$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2011$only_month[i]&meansNoStation$only_year==madrid_2011$only_year[i]]}
  if(is.nan(madrid_2011$O_3[i])){
    madrid_2011$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2011$only_month[i]&meansNoStation$only_year==madrid_2011$only_year[i]]}
  if(is.nan(madrid_2011$SO_2[i])){
    madrid_2011$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2011$only_month[i]&meansNoStation$only_year==madrid_2011$only_year[i]]}
  if(is.nan(madrid_2011$PM10[i])){
    madrid_2011$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2011$only_month[i]&meansNoStation$only_year==madrid_2011$only_year[i]]}
  
}

write.csv(madrid_2011,"dataWoNa/madrid_2011.csv", row.names = TRUE)


madrid_2012 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2012.csv")

madrid_2012$only_month <-unlist(lapply(madrid_2012$date, month))
madrid_2012$only_year <-unlist(lapply(madrid_2012$date, year))

means<-  madrid_2012 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2012 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2012$BEN)){
  if(is.na(madrid_2012$CO[i])){
    madrid_2012$CO[i]<-means$mean_CO[means$only_month==madrid_2012$only_month[i]&means$only_year==madrid_2012$only_year[i]&means$station==madrid_2012$station[i]]}
  if(is.na(madrid_2012$NO_2[i])){
    madrid_2012$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2012$only_month[i]&means$only_year==madrid_2012$only_year[i]&means$station==madrid_2012$station[i]]}
  if(is.na(madrid_2012$O_3[i])){
    madrid_2012$O_3[i]<-means$mean_O3[means$only_month==madrid_2012$only_month[i]&means$only_year==madrid_2012$only_year[i]&means$station==madrid_2012$station[i]]}
  if(is.na(madrid_2012$SO_2[i])){
    madrid_2012$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2012$only_month[i]&means$only_year==madrid_2012$only_year[i]&means$station==madrid_2012$station[i]]}
  if(is.na(madrid_2012$PM10[i])){
    madrid_2012$PM10[i]<-means$mean_PM10[means$only_month==madrid_2012$only_month[i]&means$only_year==madrid_2012$only_year[i]&means$station==madrid_2012$station[i]]}
  
}

for(i in 1:length(madrid_2012$BEN)){
  if(is.nan(madrid_2012$CO[i])){
    madrid_2012$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2012$only_month[i]&meansNoStation$only_year==madrid_2012$only_year[i]]}
  if(is.nan(madrid_2012$NO_2[i])){
    madrid_2012$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2012$only_month[i]&meansNoStation$only_year==madrid_2012$only_year[i]]}
  if(is.nan(madrid_2012$O_3[i])){
    madrid_2012$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2012$only_month[i]&meansNoStation$only_year==madrid_2012$only_year[i]]}
  if(is.nan(madrid_2012$SO_2[i])){
    madrid_2012$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2012$only_month[i]&meansNoStation$only_year==madrid_2012$only_year[i]]}
  if(is.nan(madrid_2012$PM10[i])){
    madrid_2012$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2012$only_month[i]&meansNoStation$only_year==madrid_2012$only_year[i]]}
  
}

write.csv(madrid_2012,"dataWoNa/madrid_2012.csv", row.names = TRUE)

madrid_2013 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2013.csv")

madrid_2013$only_month <-unlist(lapply(madrid_2013$date, month))
madrid_2013$only_year <-unlist(lapply(madrid_2013$date, year))

means<-  madrid_2013 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2013 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2013$BEN)){
  if(is.na(madrid_2013$CO[i])){
    madrid_2013$CO[i]<-means$mean_CO[means$only_month==madrid_2013$only_month[i]&means$only_year==madrid_2013$only_year[i]&means$station==madrid_2013$station[i]]}
  if(is.na(madrid_2013$NO_2[i])){
    madrid_2013$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2013$only_month[i]&means$only_year==madrid_2013$only_year[i]&means$station==madrid_2013$station[i]]}
  if(is.na(madrid_2013$O_3[i])){
    madrid_2013$O_3[i]<-means$mean_O3[means$only_month==madrid_2013$only_month[i]&means$only_year==madrid_2013$only_year[i]&means$station==madrid_2013$station[i]]}
  if(is.na(madrid_2013$SO_2[i])){
    madrid_2013$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2013$only_month[i]&means$only_year==madrid_2013$only_year[i]&means$station==madrid_2013$station[i]]}
  if(is.na(madrid_2013$PM10[i])){
    madrid_2013$PM10[i]<-means$mean_PM10[means$only_month==madrid_2013$only_month[i]&means$only_year==madrid_2013$only_year[i]&means$station==madrid_2013$station[i]]}
  
}

for(i in 1:length(madrid_2013$BEN)){
  if(is.nan(madrid_2013$CO[i])){
    madrid_2013$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2013$only_month[i]&meansNoStation$only_year==madrid_2013$only_year[i]]}
  if(is.nan(madrid_2013$NO_2[i])){
    madrid_2013$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2013$only_month[i]&meansNoStation$only_year==madrid_2013$only_year[i]]}
  if(is.nan(madrid_2013$O_3[i])){
    madrid_2013$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2013$only_month[i]&meansNoStation$only_year==madrid_2013$only_year[i]]}
  if(is.nan(madrid_2013$SO_2[i])){
    madrid_2013$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2013$only_month[i]&meansNoStation$only_year==madrid_2013$only_year[i]]}
  if(is.nan(madrid_2013$PM10[i])){
    madrid_2013$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2013$only_month[i]&meansNoStation$only_year==madrid_2013$only_year[i]]}
  
}

write.csv(madrid_2013,"dataWoNa/madrid_2013.csv", row.names = TRUE)

madrid_2014 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2014.csv")

madrid_2014$only_month <-unlist(lapply(madrid_2014$date, month))
madrid_2014$only_year <-unlist(lapply(madrid_2014$date, year))

means<-  madrid_2014 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2014 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2014$BEN)){
  if(is.na(madrid_2014$CO[i])){
    madrid_2014$CO[i]<-means$mean_CO[means$only_month==madrid_2014$only_month[i]&means$only_year==madrid_2014$only_year[i]&means$station==madrid_2014$station[i]]}
  if(is.na(madrid_2014$NO_2[i])){
    madrid_2014$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2014$only_month[i]&means$only_year==madrid_2014$only_year[i]&means$station==madrid_2014$station[i]]}
  if(is.na(madrid_2014$O_3[i])){
    madrid_2014$O_3[i]<-means$mean_O3[means$only_month==madrid_2014$only_month[i]&means$only_year==madrid_2014$only_year[i]&means$station==madrid_2014$station[i]]}
  if(is.na(madrid_2014$SO_2[i])){
    madrid_2014$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2014$only_month[i]&means$only_year==madrid_2014$only_year[i]&means$station==madrid_2014$station[i]]}
  if(is.na(madrid_2014$PM10[i])){
    madrid_2014$PM10[i]<-means$mean_PM10[means$only_month==madrid_2014$only_month[i]&means$only_year==madrid_2014$only_year[i]&means$station==madrid_2014$station[i]]}
  
}

for(i in 1:length(madrid_2014$BEN)){
  if(is.nan(madrid_2014$CO[i])){
    madrid_2014$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2014$only_month[i]&meansNoStation$only_year==madrid_2014$only_year[i]]}
  if(is.nan(madrid_2014$NO_2[i])){
    madrid_2014$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2014$only_month[i]&meansNoStation$only_year==madrid_2014$only_year[i]]}
  if(is.nan(madrid_2014$O_3[i])){
    madrid_2014$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2014$only_month[i]&meansNoStation$only_year==madrid_2014$only_year[i]]}
  if(is.nan(madrid_2014$SO_2[i])){
    madrid_2014$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2014$only_month[i]&meansNoStation$only_year==madrid_2014$only_year[i]]}
  if(is.nan(madrid_2014$PM10[i])){
    madrid_2014$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2014$only_month[i]&meansNoStation$only_year==madrid_2014$only_year[i]]}
  
}

write.csv(madrid_2014,"dataWoNa/madrid_2014.csv", row.names = TRUE)

madrid_2015 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2015.csv")

madrid_2015$only_month <-unlist(lapply(madrid_2015$date, month))
madrid_2015$only_year <-unlist(lapply(madrid_2015$date, year))

means<-  madrid_2015 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2015 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2015$BEN)){
  if(is.na(madrid_2015$CO[i])){
    madrid_2015$CO[i]<-means$mean_CO[means$only_month==madrid_2015$only_month[i]&means$only_year==madrid_2015$only_year[i]&means$station==madrid_2015$station[i]]}
  if(is.na(madrid_2015$NO_2[i])){
    madrid_2015$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2015$only_month[i]&means$only_year==madrid_2015$only_year[i]&means$station==madrid_2015$station[i]]}
  if(is.na(madrid_2015$O_3[i])){
    madrid_2015$O_3[i]<-means$mean_O3[means$only_month==madrid_2015$only_month[i]&means$only_year==madrid_2015$only_year[i]&means$station==madrid_2015$station[i]]}
  if(is.na(madrid_2015$SO_2[i])){
    madrid_2015$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2015$only_month[i]&means$only_year==madrid_2015$only_year[i]&means$station==madrid_2015$station[i]]}
  if(is.na(madrid_2015$PM10[i])){
    madrid_2015$PM10[i]<-means$mean_PM10[means$only_month==madrid_2015$only_month[i]&means$only_year==madrid_2015$only_year[i]&means$station==madrid_2015$station[i]]}
  
}

for(i in 1:length(madrid_2015$BEN)){
  if(is.nan(madrid_2015$CO[i])){
    madrid_2015$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2015$only_month[i]&meansNoStation$only_year==madrid_2015$only_year[i]]}
  if(is.nan(madrid_2015$NO_2[i])){
    madrid_2015$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2015$only_month[i]&meansNoStation$only_year==madrid_2015$only_year[i]]}
  if(is.nan(madrid_2015$O_3[i])){
    madrid_2015$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2015$only_month[i]&meansNoStation$only_year==madrid_2015$only_year[i]]}
  if(is.nan(madrid_2015$SO_2[i])){
    madrid_2015$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2015$only_month[i]&meansNoStation$only_year==madrid_2015$only_year[i]]}
  if(is.nan(madrid_2015$PM10[i])){
    madrid_2015$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2015$only_month[i]&meansNoStation$only_year==madrid_2015$only_year[i]]}
  
}

write.csv(madrid_2015,"dataWoNa/madrid_2015.csv", row.names = TRUE)

madrid_2016 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2016.csv")

madrid_2016$only_month <-unlist(lapply(madrid_2016$date, month))
madrid_2016$only_year <-unlist(lapply(madrid_2016$date, year))

means<-  madrid_2016 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2016 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2016$BEN)){
  if(is.na(madrid_2016$CO[i])){
    madrid_2016$CO[i]<-means$mean_CO[means$only_month==madrid_2016$only_month[i]&means$only_year==madrid_2016$only_year[i]&means$station==madrid_2016$station[i]]}
  if(is.na(madrid_2016$NO_2[i])){
    madrid_2016$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2016$only_month[i]&means$only_year==madrid_2016$only_year[i]&means$station==madrid_2016$station[i]]}
  if(is.na(madrid_2016$O_3[i])){
    madrid_2016$O_3[i]<-means$mean_O3[means$only_month==madrid_2016$only_month[i]&means$only_year==madrid_2016$only_year[i]&means$station==madrid_2016$station[i]]}
  if(is.na(madrid_2016$SO_2[i])){
    madrid_2016$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2016$only_month[i]&means$only_year==madrid_2016$only_year[i]&means$station==madrid_2016$station[i]]}
  if(is.na(madrid_2016$PM10[i])){
    madrid_2016$PM10[i]<-means$mean_PM10[means$only_month==madrid_2016$only_month[i]&means$only_year==madrid_2016$only_year[i]&means$station==madrid_2016$station[i]]}
  
}

for(i in 1:length(madrid_2016$BEN)){
  if(is.nan(madrid_2016$CO[i])){
    madrid_2016$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2016$only_month[i]&meansNoStation$only_year==madrid_2016$only_year[i]]}
  if(is.nan(madrid_2016$NO_2[i])){
    madrid_2016$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2016$only_month[i]&meansNoStation$only_year==madrid_2016$only_year[i]]}
  if(is.nan(madrid_2016$O_3[i])){
    madrid_2016$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2016$only_month[i]&meansNoStation$only_year==madrid_2016$only_year[i]]}
  if(is.nan(madrid_2016$SO_2[i])){
    madrid_2016$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2016$only_month[i]&meansNoStation$only_year==madrid_2016$only_year[i]]}
  if(is.nan(madrid_2016$PM10[i])){
    madrid_2016$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2016$only_month[i]&meansNoStation$only_year==madrid_2016$only_year[i]]}
  
}

write.csv(madrid_2016,"dataWoNa/madrid_2016.csv", row.names = TRUE)

madrid_2017 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2017.csv")

madrid_2017$only_month <-unlist(lapply(madrid_2017$date, month))
madrid_2017$only_year <-unlist(lapply(madrid_2017$date, year))

means<-  madrid_2017 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2017 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2017$BEN)){
  if(is.na(madrid_2017$CO[i])){
    madrid_2017$CO[i]<-means$mean_CO[means$only_month==madrid_2017$only_month[i]&means$only_year==madrid_2017$only_year[i]&means$station==madrid_2017$station[i]]}
  if(is.na(madrid_2017$NO_2[i])){
    madrid_2017$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2017$only_month[i]&means$only_year==madrid_2017$only_year[i]&means$station==madrid_2017$station[i]]}
  if(is.na(madrid_2017$O_3[i])){
    madrid_2017$O_3[i]<-means$mean_O3[means$only_month==madrid_2017$only_month[i]&means$only_year==madrid_2017$only_year[i]&means$station==madrid_2017$station[i]]}
  if(is.na(madrid_2017$SO_2[i])){
    madrid_2017$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2017$only_month[i]&means$only_year==madrid_2017$only_year[i]&means$station==madrid_2017$station[i]]}
  if(is.na(madrid_2017$PM10[i])){
    madrid_2017$PM10[i]<-means$mean_PM10[means$only_month==madrid_2017$only_month[i]&means$only_year==madrid_2017$only_year[i]&means$station==madrid_2017$station[i]]}
  
}

for(i in 1:length(madrid_2017$BEN)){
  if(is.nan(madrid_2017$CO[i])){
    madrid_2017$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2017$only_month[i]&meansNoStation$only_year==madrid_2017$only_year[i]]}
  if(is.nan(madrid_2017$NO_2[i])){
    madrid_2017$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2017$only_month[i]&meansNoStation$only_year==madrid_2017$only_year[i]]}
  if(is.nan(madrid_2017$O_3[i])){
    madrid_2017$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2017$only_month[i]&meansNoStation$only_year==madrid_2017$only_year[i]]}
  if(is.nan(madrid_2017$SO_2[i])){
    madrid_2017$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2017$only_month[i]&meansNoStation$only_year==madrid_2017$only_year[i]]}
  if(is.nan(madrid_2017$PM10[i])){
    madrid_2017$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2017$only_month[i]&meansNoStation$only_year==madrid_2017$only_year[i]]}
  
}

write.csv(madrid_2017,"dataWoNa/madrid_2017.csv", row.names = TRUE)

madrid_2018 <-read_csv("data/Madrid_pollution_level_dataset/csvs_per_year/madrid_2018.csv")

madrid_2018$only_month <-unlist(lapply(madrid_2018$date, month))
madrid_2018$only_year <-unlist(lapply(madrid_2018$date, year))

means<-  madrid_2018 %>%
  group_by(only_year,only_month,station) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))
meansNoStation<-  madrid_2018 %>%
  group_by(only_year,only_month) %>%
  summarize(mean_CO = mean(CO, na.rm = TRUE), mean_NO2 = mean(NO_2, na.rm = TRUE),
            mean_O3 = mean(O_3, na.rm = TRUE),mean_SO2 = mean(SO_2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE))

for(i in 1:length(madrid_2018$BEN)){
  if(is.na(madrid_2018$CO[i])){
    madrid_2018$CO[i]<-means$mean_CO[means$only_month==madrid_2018$only_month[i]&means$only_year==madrid_2018$only_year[i]&means$station==madrid_2018$station[i]]}
  if(is.na(madrid_2018$NO_2[i])){
    madrid_2018$NO_2[i]<-means$mean_NO2[means$only_month==madrid_2018$only_month[i]&means$only_year==madrid_2018$only_year[i]&means$station==madrid_2018$station[i]]}
  if(is.na(madrid_2018$O_3[i])){
    madrid_2018$O_3[i]<-means$mean_O3[means$only_month==madrid_2018$only_month[i]&means$only_year==madrid_2018$only_year[i]&means$station==madrid_2018$station[i]]}
  if(is.na(madrid_2018$SO_2[i])){
    madrid_2018$SO_2[i]<-means$mean_SO2[means$only_month==madrid_2018$only_month[i]&means$only_year==madrid_2018$only_year[i]&means$station==madrid_2018$station[i]]}
  if(is.na(madrid_2018$PM10[i])){
    madrid_2018$PM10[i]<-means$mean_PM10[means$only_month==madrid_2018$only_month[i]&means$only_year==madrid_2018$only_year[i]&means$station==madrid_2018$station[i]]}
  
}

for(i in 1:length(madrid_2018$BEN)){
  if(is.nan(madrid_2018$CO[i])){
    madrid_2018$CO[i]<-meansNoStation$mean_CO[meansNoStation$only_month==madrid_2018$only_month[i]&meansNoStation$only_year==madrid_2018$only_year[i]]}
  if(is.nan(madrid_2018$NO_2[i])){
    madrid_2018$NO_2[i]<-meansNoStation$mean_NO2[meansNoStation$only_month==madrid_2018$only_month[i]&meansNoStation$only_year==madrid_2018$only_year[i]]}
  if(is.nan(madrid_2018$O_3[i])){
    madrid_2018$O_3[i]<-meansNoStation$mean_O3[meansNoStation$only_month==madrid_2018$only_month[i]&meansNoStation$only_year==madrid_2018$only_year[i]]}
  if(is.nan(madrid_2018$SO_2[i])){
    madrid_2018$SO_2[i]<-meansNoStation$mean_SO2[meansNoStation$only_month==madrid_2018$only_month[i]&meansNoStation$only_year==madrid_2018$only_year[i]]}
  if(is.nan(madrid_2018$PM10[i])){
    madrid_2018$PM10[i]<-meansNoStation$mean_PM10[meansNoStation$only_month==madrid_2018$only_month[i]&meansNoStation$only_year==madrid_2018$only_year[i]]}
  
}

write.csv(madrid_2018,"dataWoNa/madrid_2018.csv", row.names = TRUE)

station <- read.csv("data/Madrid_pollution_level_dataset/csvs_per_year/stations.csv")

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

selected_features <- madrid_final %>% 
  select("CO", "O_3", "PM10", "NO_2", "SO_2")

selected_na <- as.data.frame(selected_features)

gg_miss_var(selected_features, show_pct = T)
  

