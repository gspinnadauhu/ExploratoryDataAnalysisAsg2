#Loading the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
#summing Emissions by year for Baltimore City
library(dplyr)
bmorecity<-NEI %>%
  filter(fips=="24510") %>%
  select(fips,Emissions,year)
NEIplot2<-with(bmorecity,tapply(Emissions,as.factor(year),sum))
barplot(NEIplot2,
        main="Plot2: Total PM2.5 emissions, Baltimore City",
        xlab="Year",
        ylab="PM 2.5 in tons")