install.packages("xlsx") # Package that contains function to read xls
library(xlsx)
library(ggplot2)

# Loads the data
dataSource <- "data/Madrid_bicycle_service_stations_dataset/bicycle_service_stations.xls"
biciData <- na.omit(read.xlsx(dataSource, sheetIndex=1, header=T))
colnames(biciData) <- c("id","gis_x","gis_y","fecha_alta","distrito","barrio","calle","num_finc", "reserv_type", "num_plaz", "long", "lat", "direcc")

summary(biciData$distrito)
summary(biciData$barrio)
summary(biciData$num_plaz)

ggplot(biciData, aes(x = num_plaz)) +
  geom_histogram(binwidth = ) +
  xlab("District") + ylab("Frequence") + ggtitle("District distribution") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
