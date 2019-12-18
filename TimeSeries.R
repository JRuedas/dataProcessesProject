library(dplyr)
library(utils) # for the read.csv
library(data.table) # For the rbindlist
library(ggplot2) # for plots
library(ggfortify)
library(gridExtra)
library(forecast)

# Load CSVs
setwd("~/dataProcessesProject/")

madrid_2012 <-read.csv("dataWoNa/madrid_2012.csv", sep = ",", header = T)
madrid_2013 <-read.csv("dataWoNa/madrid_2013.csv", sep = ",", header = T)
madrid_2014 <-read.csv("dataWoNa/madrid_2014.csv", sep = ",", header = T)
madrid_2015 <-read.csv("dataWoNa/madrid_2015.csv", sep = ",", header = T)
madrid_2016 <-read.csv("dataWoNa/madrid_2016.csv", sep = ",", header = T)
madrid_2017 <-read.csv("dataWoNa/madrid_2017.csv", sep = ",", header = T)
station <- read.csv("data/Madrid_pollution_level_dataset/stations.csv", sep = ",", header = T)

# Group CSVs
madrid_list <- list(madrid_2012, madrid_2013, madrid_2014, madrid_2015,madrid_2016, madrid_2017)
madrid_temp <- as.data.frame(rbindlist(madrid_list, fill = T))

remove(madrid_2012)
remove(madrid_2013)
remove(madrid_2014)
remove(madrid_2015)
remove(madrid_2016)
remove(madrid_2017)
remove(madrid_list)

# Data Wrangling
madrid_air <- madrid_temp[with(madrid_temp, order(date)),]
madrid_air$date<-as.POSIXct(madrid_air$date,format = "%Y-%m-%d %H:%M:%S", tz='CET')

#################### Time series ########################################

pollutant <- madrid_air %>%
  as.data.frame %>%
  mutate(date_ymd=as.Date(date,format="%Y-%m-%d")) %>%
  group_by(date_ymd) %>%
  summarise(max_pol=max(O_3,na.rm=TRUE)) %>%
  as.data.frame %>%
  mutate(y_m=paste(substr(date_ymd,1,nchar(date_ymd)+2),"-01")) %>%
  group_by(y_m) %>%
  summarise(avg_emission=mean(max_pol,na.rm=TRUE))

pollutants_evolution <- data.frame("date"=as.Date(pollutant$y_m,format="%Y - %m - %d"),"count"=pollutant$avg_emission)

#converting to time series    
pollutants_ts<-ts(pollutants_evolution$count,frequency = 12,start = c(2012,01))

#ggplot format of ts plot    
autoplot(pollutants_ts, ts.colour="red") +
  xlab('Date') +
  ylab('Count') +
  ggtitle('Evolution of the Ozone') +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

pollutant_ts_decomposed<-decompose(pollutants_ts)

time_series <- autoplot(pollutant_ts_decomposed$x) +
  xlab("Year") +
  ylab("Count") +
  ggtitle("Ozone time series") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

seasonality <- autoplot(pollutant_ts_decomposed$seasonal) +
  xlab("Year") +
  ylab("Count") +
  ggtitle("Seasonality")+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

trend <- autoplot(pollutant_ts_decomposed$trend) +
  xlab("Year") +
  ylab("Count") +
  ggtitle("Trend") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

grid.arrange(time_series,seasonality,trend,ncol=2,top="Parameters of the Ozone time series")

#### ETS for predictions ####

plotForecastErrors <- function(forecasterrors) {
  # makes a histogram of the error:
  mybinsize <- IQR(forecasterrors)/4
  mysd   <- sd(forecasterrors)
  mymin  <- min(forecasterrors) - mysd*5
  mymax  <- max(forecasterrors) + mysd*3
  
  # generates normally distributed data
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm)
  mymax2 <- max(mynorm)
  if (mymin2 < mymin) { mymin <- mymin2 }
  if (mymax2 > mymax) { mymax <- mymax2 }
  
  # makes a red histogram of the errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  
  # generates normally distributed data
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  
  # plot the curve as a blue line on top of the histogram of errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}

### ETS

train_ts<-ts(pollutants_ts,start = c(2012,01),end=c(2017,12),frequency = 12)
train_pollutants_fit_ets<-ets(train_ts) 
train_pollutants_fit_ets
train_forecast_ets<-forecast:::forecast.ets(train_pollutants_fit_ets,24)

train_forecast_ets_pt<-data.frame(train_forecast_ets)$Point.Forecast

forecast_train<-data.frame("x"=as.Date(pollutants_evolution$date[49:72],format="%Y - %m - %d"),"y"=train_forecast_ets_pt)
actual_train<-data.frame("x"=as.Date(pollutants_evolution$date,format="%Y - %m - %d"),"y"=pollutants_evolution$count)

#Plot forecast vs actual

ggplot(forecast_train,aes(x,y)) +
  geom_line(aes(color="First line")) +
  geom_line(data = actual_train,aes(color="Second line"))+xlab("Year")+ylab("Count") +
  labs(color="Series") +
  ggtitle("Training Vs Testing plot") +
  scale_colour_manual(values = c("red","green"), labels=c("Forecast", "Actual")) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

#Error
train_forecast_ets$residuals<-na.omit(train_forecast_ets$residuals)
plotForecastErrors(train_forecast_ets$residuals)

#ACF
acf_var_ets<-acf(na.omit(train_forecast_ets$residuals),plot=F)
plot(acf_var_ets, main="ACF plot")

#Residuals
autoplot(train_forecast_ets$residuals) +labs(x='Date',y='Residuals',title='Residual plot') +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))