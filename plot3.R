#Loading the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
#subsetting for Baltimore city and totalling emissions by type
##subset
library(dplyr)
bmorecity_type<-NEI %>%
  filter(fips=="24510") %>%
  select(fips,Emissions,type,year)
##sum by type by year
bmorecity_type<-with(bmorecity_type,tapply(Emissions,list(as.factor(year),as.factor(type)),sum))
bmorecity_type<-as.data.frame(bmorecity_type)
#plot
library(ggplot2)
ggplot(data=bmorecity_type,aes(x=year,y=Emissions))+
  geom_bar()+
  facet_grid(.~type)