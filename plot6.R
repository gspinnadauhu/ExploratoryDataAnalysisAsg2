#Loading the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
##subsetting EI.Sector containg "Vehicle"
library(dplyr)
vehicle_SCC<-SCC %>%
  filter(grepl('Vehicle',EI.Sector)) %>%
  select(SCC)
##subset NEI for Bmore City & LA Cnty and based on vehicle_SCC
LA_BM_vehicle<-NEI %>%
  filter(SCC %in% vehicle_SCC$SCC & fips %in% c("24510","06037")) %>%
  select(fips,Emissions,year)
LA_BM_vehicle$year<-as.factor(LA_BM_vehicle$year)
LA_BM_vehicle$fips<-as.factor(LA_BM_vehicle$fips)
#plot
library(ggplot2)
ggplot(data=LA_BM_vehicle,aes(x=year,y=Emissions))+
  stat_summary(fun.y=sum,geom="bar")+
  facet_grid(fips~.,scales="free_y")
  labs(y="PM 2.5 in tons",
       x="Year",
       title="Plot5: LA County vs Baltimore City Emissions from Vehicles 1999-2008")