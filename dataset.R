library(ggplot2)

# Loads the data
biciData <- na.omit(read.csv("data/Madrid_pollution_level_dataset/csvs_per_year/csvs_per_year/madrid_2001.csv", sep = "", header = T))

summary(biciData$distrito)
summary(biciData$barrio)
summary(biciData$num_plaz)

ggplot(biciData, aes(x = num_plaz)) +
  geom_histogram(binwidth = ) +
  xlab("District") + ylab("Frequence") + ggtitle("District distribution") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
