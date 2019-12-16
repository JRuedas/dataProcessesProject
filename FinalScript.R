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
library(scales)
# Load CSVs
madrid_2016 <-read_csv("dataWoNa/madrid_2016.csv")
madrid_2017 <-read_csv("dataWoNa/madrid_2017.csv")
madrid_2018 <-read_csv("dataWoNa/madrid_2018.csv")

station <- read.csv("data/Madrid_pollution_level_dataset/stations.csv")

# Group CSVs
madrid_list <- list(madrid_2016, madrid_2017, madrid_2018)
madrid_18 <- as.data.frame(rbindlist(madrid_list, fill = T))

madrid_18$only_day <-unlist(lapply(madrid_18$date, day))

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

# Missing values:
madrid_final1$CO[is.na(madrid_final1$CO)] <- round(mean(madrid_final1$CO, na.rm = TRUE))
madrid_final1$O_3[is.na(madrid_final1$O_3)] <- round(mean(madrid_final1$O_3, na.rm = TRUE))
madrid_final1$PM10[is.na(madrid_final1$PM10)] <- round(mean(madrid_final1$PM10, na.rm = TRUE))
madrid_final1$NO_2[is.na(madrid_final1$NO_2)] <- round(mean(madrid_final1$NO_2, na.rm = TRUE))
madrid_final1$SO_2[is.na(madrid_final1$SO_2)] <- round(mean(madrid_final1$SO_2, na.rm = TRUE))

plot_pollutant<-function(pol,title,colour){
  pol<-enquo(pol)
  date_df<-madrid_final%>%
    mutate(date_ymd=as.Date(date,format="%Y-%m-%d"))%>%
    group_by(date_ymd)%>%
    summarise(max_emission=max(!!pol,na.rm=TRUE))
  
  plot1<-ggplot(data=date_df,aes(x=date_ymd,y=max_emission))+geom_line(color=colour)+
    scale_x_date(breaks = seq(as.Date("2001-01-01"), as.Date("2018-01-01"), by="6 months"),labels = date_format("%b-%y"))+
    xlab('Date')+ylab('ug/m3')+ggtitle(paste('Daily Maximum Emission of',title))+
    theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")
  
  month_df<-date_df%>%
    mutate(y_m_d=paste(substr(date_ymd,1,nchar(date_ymd)+2),"-01"))%>%
    group_by(y_m_d)%>%
    summarise(avg_emission=mean(max_emission,na.rm=TRUE))
  
  
  plot2<-ggplot(data=month_df,aes(x=as.Date(y_m_d, format = "%Y - %m - %d"),y=avg_emission))+geom_line(color=colour)+
    scale_x_date(breaks = seq(as.Date("2001-01-01"), as.Date("2018-01-01"), by="6 months"), date_labels = "%b-%y")+
    xlab('Date')+ylab('ug/m3')+ggtitle(paste('Monthly Average Emission of',title))+
    theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")
  grid.arrange(plot1,plot2,nrow=2)
}

plot_pollutant(O_3,"Ozone","magenta3")
