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
madrid_2010 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2010.csv")
madrid_2011 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2011.csv")
madrid_2012 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2012.csv")
madrid_2013 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2013.csv")
madrid_2014 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2014.csv")
madrid_2015 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2015.csv")
madrid_2016 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2016.csv")
madrid_2017 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2017.csv")
madrid_2018 <-read_csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/dataWoNa/madrid_2018.csv")

station <- read.csv("/home/laura/MUII/Primero/data_processes/project/dataProcessesProject/data/Madrid_pollution_level_dataset/stations.csv")

# Group CSVs
madrid_list <- list(madrid_2010, madrid_2011, madrid_2012, madrid_2013,
                    madrid_2014, madrid_2015, madrid_2016, madrid_2017, madrid_2018)
madrid_18 <- as.data.frame(rbindlist(madrid_list, fill = T))

madrid_18$only_day <-unlist(lapply(madrid_18$date, day))

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

madrid_final_exp <- as.data.frame(lapply(selected_features, unlist))
madrid_final_exp$only_year <- as.factor(madrid_final_exp$only_year)
madrid_final_exp$only_month <- as.factor(madrid_final_exp$only_month)
madrid_final_exp$station <- as.factor(madrid_final_exp$station)

gg_miss_var(dplyr::select(madrid_final_exp, 4:8), show_pct = T) #missing values just for the 5 variables that we use

#EXPLORATORY DATA ANALYSIS

# 1. Center and distribution measures (boxplots and histograms)
melt_madrid_final_1 <- melt(madrid_final_exp,id.vars='station', measure.vars=c('O_3','PM10','NO_2','SO_2', 'CO'))
box_plot <- ggplot(melt_madrid_final_1,aes(x=variable, y=value, color=variable)) +
  geom_boxplot()+ coord_flip()+
  scale_colour_manual(values=c("magenta3","goldenrod3","brown","lightslateblue", "green"))+
  theme(legend.position="none")+scale_y_continuous(breaks = seq(0, 700, by = 50))+
  labs(title="Distribution of pollutants",x='Pollutants',y='ug/m3')
histograms <-ggplot(melt_madrid_final_1,aes(x = value,fill=variable)) + 
  facet_wrap(~variable, nrow = 1) + 
  geom_histogram(binwidth=20)+
  scale_fill_manual(values=c("magenta3","goldenrod3","brown","lightslateblue", "green"))+
  theme(legend.position="none")+
  labs(x='ug/m3',y='Pollutants')

grid.arrange(box_plot,histograms,nrow=2)

# 2. Linear relationships:

#Covariance and Correlation matrix, omitting date and station columns
madrid_final_exp_features = dplyr::select(madrid_final_exp, 5:9)
s <- cov(madrid_final_exp_features)
r <- cor(madrid_final_exp_features)

corrplot.mixed(r, lower="number", upper="ellipse")

#determinant of the correlation matrix: if the value is very low, there are high correlations among the variables in our dataset
det(r)


# 3. Data insights 
# 2.1 see the maximum for each variable in each day for each month each year
plot_scale_monthly <- function(pol,title,colour) {
  pol <- enquo(pol)
  
  daily_max<-madrid_final_exp%>%
    mutate(date_ymd=as.Date(date,format="%Y-%m-%d"))%>%
    group_by(date_ymd)%>%
    summarise(max_emission=max(!!pol,na.rm=TRUE))
  month_avg<-daily_max%>%
    mutate(y_m_d=paste(substr(date_ymd,1,nchar(date_ymd)+2),"-01"))%>%
    group_by(y_m_d)%>%
    summarise(avg_emission=mean(max_emission,na.rm=TRUE))
  
  ggplot(data=month_avg,aes(x=as.Date(y_m_d,format="%Y - %m - %d"),y=scale(avg_emission)))+ geom_line(color=colour)+
    scale_x_date(breaks = seq(as.Date("2001-01-01"), as.Date("2018-01-01"), by="12 months"), date_labels = "%Y")+
    xlab('')+ylab(title)+
    theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")   
}

p1<-plot_scale_monthly(O_3,"O_3","magenta3")
p2<-plot_scale_monthly(PM10,"PM10","goldenrod3")
p3<-plot_scale_monthly(NO_2,"NO_2","brown")
p4<-plot_scale_monthly(SO_2,"SO_2","lightslateblue")
p5 <- plot_scale_monthly(CO,"CO","green")
grid.arrange(p1,p2,p3,p4,p5,nrow=5,top = "Monthly Averaged on Daily Maximum Values")
