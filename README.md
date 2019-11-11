# Data Processes Project

This repository is created to hold the code for the project of Data Processes subject

## Authors

* Alejandro Basco Plaza
* Raul Cruz Benita
* Jonatan Ruedas Mora
* Laura Sanchez de Rojas Huerta
* Miriam Zaragoza Pastor

## Domain of interest

> ### 1. Description

Some group members that live in the outskirts of Madrid are thinking about buying an apartment in the city center. In the last decade, some areas from Madrid have been closed to traffic due to the high pollution levels. We can look at it at the following links:

* [El País 25/12/2018](https://elpais.com/ccaa/2018/12/25/madrid/1545733669_183707.html)
* [El País 15/01/2019](https://elpais.com/ccaa/2019/01/15/madrid/1547552287_304449.html)
* [ABC 25/02/2019](https://www.abc.es/espana/madrid/abci-ayuntamiento-madrid-activa-escenario-1-protocolo-alta-contaminacion-201902252255_noticia.html)

There have also been important issues with urban garbage collection, leading to real problems of waste accumulation in the street:

* [El País 24/12/2018](https://elpais.com/ccaa/2018/12/19/madrid/1545246067_538347.html)

Apart from that, one of the most heated debates revolves around the use of the car in the center of Madrid. Nowadays there are some restrictions when the pollution levels are over a certain values but there also is an on going plan to improve the life quality by avoiding the most polluting cars to enter in the city.

* [El País 30/09/2019](https://elpais.com/ccaa/2019/09/30/madrid/1569824646_593497.html)

> ### 2. Why are you interested in this field/domain?

We are especially concerned about the pollution level in our future neighborhood, and also want to take into account district preferences and issues such as urban cleanness and stationary allergies when determining **which area of Madrid would be the most suitable one to buy an apartment**.

> ### 3. What other examples of data driven project have you found related to this domain?

These are some projects that we found about pollution in Madrid.

* [Madrid's Air Quality Exhaustive Tutorial on Stationarity, Smoothing, and Seasonality](https://www.kaggle.com/nholloway/stationarity-smoothing-and-seasonality "Stationarity, Smoothing, and Seasonality")

* [Explore air quality in Madrid](https://www.kaggle.com/dgildas/explore-air-quality-in-madrid "Explore air quality in Madrid")

* [Madrid's pollution weekly mean values](https://www.kaggle.com/fjortag/interactive-plot-showing-weekly-mean-values "Interactive plot showing weekly mean values")

After reading them all and see how they examined the data, we choose the first one. This project is very interesting for us, because the study is based on the CO2, according to the district and the stationary.

These data are from [Madrid's City Council Open Data website](https://datos.madrid.es/portal/site/egob "Madrid's City Council Open Data website"), which is a website where the Community of Madrid shares open data. We have chosen data from the air quality where we can see the levels of differents particles per year in some differents stations in Madrid. Not all of the stations collect the same data about particles because some of them are different and do not have the same equipment. These brute data have been processed to work easier with them, and we have found it at [Kaggle's website](https://www.kaggle.com/ "Kaggle's website").


> ### 4. What data-driven questions do you hope to answer about this domain?

1. How much has the use of public transport increased in the most polluted areas?
2. How much does the rental price vary from a heavily polluted area to another with less pollution?
3. How much does the number of people affected by lung diseases increase when pollution level's grow from one year to the next?
4. I prefer the districts of Arganzuela and Retiro. Which of the two districts has had a lower CO2 index in the last 5 years?
5. I have allergy problems in Spring season. Which is the district that has the lowest pollution levels?
6. In the last 10 years, which station has had the highest level of accumulated CO2?
7. In the last 10 years, which station has had the lowest accumulated CO2 level?
8. Which district has had the highest pollution levels in the last 10 years?
9. Which district has had the lowerst pollution levels in the last 10 years?
10. On average, which district is the one with the highest amount of road waste (in kg) collected during the months from june to September of 2019?
11. During the winter of 2017 (From December to March), which waste type was the most collected one on average?
12. On average, which district is the one that has the highest number of m2 of graffiti removal in the last three years?
13. Which district has a greater number of dog bag dispensers?
14. What district has furniture collection?
15. Which district has had the more bicycle available places? 
16. Are there more bicycles in those districts with less CO2 levels?
17. On average, which district has the newest bicycle stations? And the older ones?
18. Which district has had the more bicycle stations?


## Finding data

### Dataset 1

* [Air Quality in Madrid (2001-2018) dataset](https://www.kaggle.com/decide-soluciones/air-quality-madrid "Air Quality in Madrid (2001-2018)")

> #### 1. Where did you download the data?

The information used was taken from [Kaggle's website](https://www.kaggle.com/ "Kaggle's website"). On this page, we can find a lot of information and datasets about the air quality in Madrid.

> #### 2. How was the data collected or generated?

The data of the data set has been collected from the original files provided by [Madrid Open Data.](https://datos.madrid.es/portal/site/egob/menuitem.c05c1f754a33a9fbe4b2e4b284f1a5a0/?vgnextoid=9e42c176313eb410VgnVCM1000000b205a0aRCRD&vgnextchannel=374512b9ace9f310VgnVCM100000171f5a0aRCRD&vgnextfmt=default) Decide soluciones organization processed them and uploaded to the [Kaggle's website](https://www.kaggle.com/decide-soluciones/air-quality-madrid)

Originally, Madrid Open Data get the data from 24 automatic stations around Madrid. Those stations, which are set around all the districts of the city, record information about pollution in the area. The data was generated from those stations whose pollution sensors measure air quality in Madrid city.

> #### 3. How many observations are in your data?

All csv files include twelve month data except the last one that only has data until  May. According to this, we have the followings rows:

| CSV | Observations |
| --- | ------------ |
| Stations.csv | 24 rows |
| Madrid2001.csv | 217872 rows |
| Madrid2002.csv | 217296 rows |
| Madrid2003.csv | 243984 rows |
| Madrid2004.csv | 245496 rows |
| Madrid2005.csv | 237000 rows |
| Madrid2006.csv | 230568 rows |
| Madrid2007.csv | 225120 rows |
| Madrid2008.csv | 226392 rows |
| Madrid2009.csv | 215688 rows |
| Madrid2010.csv | 209448 rows |
| Madrid2011.csv | 209928 rows |
| Madrid2012.csv | 210720 rows |
| Madrid2013.csv | 209880 rows |
| Madrid2014.csv | 210024 rows |
| Madrid2015.csv | 210096 rows |
| Madrid2016.csv | 209496 rows |
| Madrid2017.csv | 210120 rows |
| Madrid2018.csv | 69096 rows |

> #### 4. How many features are in the data?

In this case, we can differentiate two domains whose columns represent different data.

On the one hand, we have Stations.csv with six columns. On the other hand, we have Madrid20xx.csv. Some of these csv files have 14 columns, others 16 and others 17, this is because not all have the data such as Madrid2003.csv does not have the data PM25,  Madrid2011.csv. does not have MXY, OXY and PXY, etc. So we have the following columns in the csv files:

| CSV | Features |
| --- | -------- |
| Stations.csv | 6 columns |
| Madrid2001.csv | 16 columns |
| Madrid2002.csv | 16 columns |
| Madrid2003.csv | 16 columns |
| Madrid2004.csv | 17 columns |
| Madrid2005.csv | 17 columns |
| Madrid2006.csv | 17 columns |
| Madrid2007.csv | 17 columns |
| Madrid2008.csv | 17 columns |
| Madrid2009.csv | 17 columns |
| Madrid2010.csv | 17 columns |
| Madrid2011.csv | 14 columns |
| Madrid2012.csv | 14 columns |
| Madrid2013.csv | 14 columns |
| Madrid2014.csv | 14 columns |
| Madrid2015.csv | 14 columns |
| Madrid2016.csv | 14 columns |
| Madrid2017.csv | 16 columns |
| Madrid2018.csv | 16 columns |

> #### 5. What questions can be answered using the data in this dataset?

According to the information we have we can answer the following questions:

1. I prefer the districts of Arganzuela and Retiro. Which of the two districts has had a lower CO2 index in the last 5 years?
2. I have allergy problems during Spring. Which district has the lowest pollution levels in the first place?
3. In the last 10 years, which station has had the highest level of accumulated CO2?
4. In the last 10 years, which station has had the lowest accumulated CO2 level?
5. Which district has had the highest pollution levels in the last 10 years?
6. Which district has had the lowest pollution levels in the last 10 years?

The rest of the questions cannot be answered because we do not have enough information on certain topics such as prices or the use of public transport. In case we want to answer them we should conduct a study on these matters.


### Dataset 2

* [Actions in urban cleanness dataset (01/01/2017-30/09/2019)](https://datos.madrid.es/portal/site/egob/menuitem.c05c1f754a33a9fbe4b2e4b284f1a5a0/?vgnextoid=6d45adbb460dd510VgnVCM2000001f4a900aRCRD&vgnextchannel=374512b9ace9f310VgnVCM100000171f5a0aRCRD&vgnextfmt=default)

> #### 1. Where did you download the data?

The dataset was found in the [Madrid's city council open data source](https://datos.madrid.es/portal/site/egob/ "Madrid's city council open data source"). In this website, we can find several datasets containing information about different aspects of Madrid.

> #### 2. How was the data collected or generated?

The data was collected by the environment and urban planning department of Madrid's city council.

> #### 3. How many observations are in your data?

There are three csv files for each year (2017, 2018 and 2019), measuring the same features related to urban cleanness. The number of observations on each of these datasets is shown in the table below:

| CSV | Observations |
| --- | ------------ |
| actuacionesLimpiezaUrbana2019.csv | 253 rows |
| actuacionesLimpiezaUrbana2018.csv | 253 rows |
| actuacionesLimpiezaUrbana2017.csv | 253 rows |

> #### 4. How many features are in the data?

In this dataset, the three csv files that compose the observations for 2017, 2018 and 2019 measure the same 13 features.

> #### 5. What questions can be answered using the data in this dataset?

Using the information in the dataset, we can answer the following questions:

1. On average, which district is the one with the highest amount of road waste (in kg) collected during the months from june to September of 2019?
2. During the winter of 2017 (From December to March), which waste type was the most collected one on average?
3. On average, which district is the one that has the highest number of m2 of graffiti removal in the last three years?
4. Which district has a greater number of dog bag dispensers?
5. What district has furniture collection?

### Dataset 3

* [Public bicycle service stations in Madrid dataset](https://datos.madrid.es/sites/v/index.jsp?vgnextoid=e9b2a4059b4b7410VgnVCM2000000c205a0aRCRD&vgnextchannel=374512b9ace9f310VgnVCM100000171f5a0aRCRD)

> #### 1. Where did you download the data?

The dataset was found in the [Madrid's city council open data source](https://datos.madrid.es/portal/site/egob/ "Madrid's city council open data source"). In this website, we can find several datasets containing information about different aspects of Madrid.

> #### 2. How was the data collected or generated?

The data was collected by Madrid's city council.

> #### 3. How many observations are in your data?

There is only one CSV in this dataset which includes 216 observations.

> #### 4. How many features are in the data?

The CSV includes 13 features that include several information such as the address or the coordinates.

> #### 5. What questions can be answered using the data in this dataset?

Using the information in the dataset, we can answer the following questions:

1. Which district has had the more bicycle available places? 
2. Which district has the newest bicycle stations? And the older ones?
3. On average, which district has had the more bicycle stations?
