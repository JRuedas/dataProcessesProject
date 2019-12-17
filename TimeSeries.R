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

remove(madrid_2016)
remove(madrid_2017)
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
pol_ts<-ts(pol_flow$count,frequency = 12,start = c(2012,01))

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

#### ETS for predictions ####

plotForecastErrors <- function(forecasterrors)
{
  # make a histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors)/4
  mysd   <- sd(forecasterrors)
  mymin  <- min(forecasterrors) - mysd*5
  mymax  <- max(forecasterrors) + mysd*3
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm)
  mymax2 <- max(mynorm)
  if (mymin2 < mymin) { mymin <- mymin2 }
  if (mymax2 > mymax) { mymax <- mymax2 }
  # make a red histogram of the forecast errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1
  # generate normally distributed data with mean 0 and standard deviation mysd
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}

### ETS

train_ts<-ts(pol_ts,start = c(2012,01),end=c(2017,12),frequency = 12)
train_pol_fit_ets<-ets(train_ts) 
train_pol_fit_ets
train_forecast_ets<-forecast:::forecast.ets(train_pol_fit_ets,24)

train_forecast_ets_df<-data.frame(train_forecast_ets)
train_forecast_ets_pt_forecast<-train_forecast_ets_df$Point.Forecast

forecast_train<-data.frame("x"=as.Date(pol_flow$date[49:72],format="%Y - %m - %d"),"y"=train_forecast_ets_pt_forecast)
actual_train<-data.frame("x"=as.Date(pol_flow$date,format="%Y - %m - %d"),"y"=pol_flow$count)

ggplot(forecast_train,aes(x,y))+geom_line(aes(color="First line")) +
  geom_line(data = actual_train,aes(color="Second line"))+xlab("Year")+ylab("Count")+
  labs(color="Series")+ggtitle("Training Vs Testing plot")+
  scale_colour_manual(values = c("red","green"), 
                      labels=c("Forecast", "Actual"))

train_forecast_ets$residuals<-na.omit(train_forecast_ets$residuals)
plotForecastErrors(train_forecast_ets$residuals)

#ACF
acf_var_ets<-acf(na.omit(train_forecast_ets$residuals),lag.max = 10,plot=FALSE)
autoplot(acf_var_ets)+labs(x='Lag',y='ACF',title='ACF plot')

#Residuals
autoplot(train_forecast_ets$residuals)+labs(x='Date',y='Residuals',title='Residual plot')