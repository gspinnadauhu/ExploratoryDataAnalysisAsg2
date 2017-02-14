#Loading the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
#subsetting for vehicle related sources and Baltimore City
##subsetting EI.Sector containg "Vehicle"
library(dplyr)
vehicle_SCC<-SCC %>%
  filter(grepl('Vehicle',EI.Sector)) %>%
  select(SCC)
##subset NEI for Bmore City and based on vehicle_SCC
NEI_vehicle<-NEI %>%
  filter(SCC %in% vehicle_SCC$SCC & fips=="24510") %>%
  select(Emissions,year)
NEI_vehicle$year<-as.factor(NEI_vehicle$year)
#plot
library(ggplot2)
ggplot(data=NEI_vehicle,aes(x=year,y=Emissions))+
  stat_summary(fun.y=sum,geom="bar")+
  labs(y="PM 2.5 in tons",
       x="Year",
       title="Plot5: U.S. Emissions from Vehicles 1999-2008")
dev.copy(device=png,file="plot5.png",height=480,width=680)
dev.off()
