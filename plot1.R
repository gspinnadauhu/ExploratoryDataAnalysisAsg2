#Loading the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
#summing Emissions by year
NEIplot1<-with(NEI,tapply(Emissions,as.factor(year),sum))
barplot(NEIplot1,
        main="Plot1: Total PM2.5 emissions",
        xlab="Year",
        ylab="PM 2.5 in tons")