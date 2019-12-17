library(dplyr)
library(utils) # for the read.csv
library(data.table) # For the rbindlist
library(ggplot2) # for plots
library(ggfortify)
library(gridExtra)
library(forecast)

# Load CSVs
setwd("~/dataProcessesProject/")

madrid_2016 <-read.csv("dataWoNa/madrid_2016.csv", sep = ",", header = T)
madrid_2017 <-read.csv("dataWoNa/madrid_2017.csv", sep = ",", header = T)
madrid_2018 <-read.csv("dataWoNa/madrid_2018.csv", sep = ",", header = T)
station <- read.csv("data/Madrid_pollution_level_dataset/stations.csv", sep = ",", header = T)

# Group CSVs
madrid_list <- list(madrid_2016, madrid_2017, madrid_2018)
madrid_temp <- as.data.frame(rbindlist(madrid_list, fill = T))

remove(madrid_2016)
remove(madrid_2017)
remove(madrid_2018)
remove(madrid_list)

# Data Wrangling
madrid_final <- madrid_temp[with(madrid_temp, order(date)),]
madrid_final$date<-as.POSIXct(madrid_final$date,format = "%Y-%m-%d %H:%M:%S", tz='CET')

#################### Time series ########################################

pollutant <- madrid_final %>%
  as.data.frame %>%
  mutate(date_ymd=as.Date(date,format="%Y-%m-%d")) %>%
  group_by(date_ymd) %>%
  summarise(max_pol=max(O_3,na.rm=TRUE)) %>% # Can change the pollutant name here.Rest all codes works without change
  as.data.frame %>%
  mutate(y_m=paste(substr(date_ymd,1,nchar(date_ymd)+2),"-01")) %>%
  group_by(y_m) %>%
  summarise(avg_emission=mean(max_pol,na.rm=TRUE))

pol_flow <- data.frame("date"=as.Date(pollutant$y_m,format="%Y - %m - %d"),"count"=pollutant$avg_emission)

#converting to time series    
pol_ts<-ts(pol_flow$count,frequency = 12,start = c(2016,01))

#ggplot format of ts plot    
autoplot(pol_ts, ts.colour="darkgreen") +
  xlab('Date') +
  ylab('Count') +
  ggtitle('Time Series of Ozone Pollutant')

pol_ts_decompose<-decompose(pol_ts)

actual <- autoplot(pol_ts_decompose$x) +
  xlab("Year") +
  ylab("Count") +
  ggtitle("Actual time series of ozone")

seas <- autoplot(pol_ts_decompose$seasonal) +
  xlab("Year") +
  ylab("Count") +
  ggtitle("Seasonality time series of ozone")

tren <- autoplot(pol_ts_decompose$trend) +
  xlab("Year") +
  ylab("Count") +
  ggtitle("Trend time series of ozone")

grid.arrange(actual,seas,tren,ncol=1,top="Decomposition of Ozone time series")

#### Arima for predictions ####

### Training Arima
train_ts<-ts(pol_ts,start = c(2016,01),end=c(2018,12),frequency = 12)
train_pol_fit_arima<-auto.arima(train_ts)
train_pol_fit_arima

train_forecast_arima<-forecast(train_pol_fit_arima,24)

train_forecast_arima_df<-data.frame(train_forecast_arima)
train_forecast_arima_pt_forecast<-train_forecast_arima_df$Point.Forecast

forecast_train_arima<-data.frame("x"=as.Date(pol_flow$date[181:204],format="%Y - %m - %d"),"y"=train_forecast_arima_pt_forecast)
actual_train_arima<-data.frame("x"=as.Date(pol_flow$date,format="%Y - %m - %d"),"y"=pol_flow$count)

ggplot(forecast_train_arima,aes(x,y)) +
  geom_line(aes(color="First line")) +
  geom_line(data = actual_train_arima,aes(color="Second line")) +
  xlab("Year") +
  ylab("Count")+
  labs(colors="Series") +
  ggtitle("Training Vs Testing plot")+
  scale_colour_manual(values = c("red","green"), 
                      labels=c("Forecast", "Actual"))
