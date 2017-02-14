#Loading the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
#subsetting for coal emissions and summarizing
##subset SCC for EI.Sector containing word "coal"
library(dplyr)
coal_SCC<-SCC %>%
  filter(grepl('Coal',EI.Sector)) %>%
  select(SCC)
##subset NEI based on coal_SCC
NEI_coal<-NEI %>%
  filter(SCC %in% coal_SCC$SCC) %>%
  select(Emissions,year)
NEI_coal$year<-as.factor(NEI_coal$year)
#plot
library(ggplot2)
ggplot(data=NEI_coal,aes(x=year,y=Emissions))+
  stat_summary(fun.y=sum,geom="bar")+
  labs(y="PM 2.5 in tons",
       x="Year",
       title="Plot4: U.S. Emissions from Coal related sources 1999-2008")