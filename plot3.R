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
bmorecity_type<-with(bmorecity_type,aggregate(Emissions,by=list(year,type),sum))
names(bmorecity_type)<-c("Year","Type","Emissions")
#plot
library(ggplot2)
ggplot(data=bmorecity_type,aes(x=as.factor(Year),y=Emissions))+
  geom_bar(stat="identity")+
  facet_grid(.~Type)