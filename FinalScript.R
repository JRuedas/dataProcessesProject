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

selected_features <- madrid_final %>% 
                      select("CO", "O_3", "PM10", "NO_2", "SO_2")

selected_na <- as.data.frame(selected_features)

gg_miss_var(selected_features, show_pct = T)
