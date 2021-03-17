### Question 1:
data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                      destfile = "./Getting and Cleaning Data/data/housing.csv",
                      method = "curl")

house <- read.csv("./Getting and Cleaning Data/data/housing.csv")

names <- strsplit(names(house), "wgtp")
names[[123]]


### Question 2:

dat <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                     destfile = "./Getting and Cleaning Data/data/gdp2.csv",
                     method = "curl")

gg <- read.csv("./Getting and Cleaning Data/data/gdp2.csv",  sep=",", skip = 3)



GDP <- gg %>%
  as_tibble %>%
  select(1,2,4,5) %>%
  rename(Country=X, USD=US.dollars.) %>%
  mutate(USD2=str_replace_all(USD, ",", ""))

GDP <-  GDP[c(2:191),] 

aver <- mean(as.numeric(GDP$USD2), na.rm = TRUE)

### Question 3:

dat <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                     destfile = "./Getting and Cleaning Data/data/gdp2.csv",
                     method = "curl")

gg <- read.csv2("./Getting and Cleaning Data/data/gdp2.csv",  sep=",", skip = 3)


GDP <- gg %>%
  as_tibble %>%
  select(1,2,4,5) %>%
  rename(Country=X, USD=US.dollars.)

GDP <-  GDP[c(2:191),] 

countryNames <- GDP$Economy
nn <- grep("*United", countryNames)
length(nn)

### Question 4:

dat <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                     destfile = "./Getting and Cleaning Data/data/GDP.csv",
                     method = 'curl')

GDP <- read.csv2("./Getting and Cleaning Data/data/GDP.csv", sep=",", skip = 3)

GDP <- GDP %>%
  as_tibble %>%
  select(1,2,4,5) %>%
  rename(Country=X, USD=US.dollars.)

GDP <-  GDP[c(2:191),] 
GDP$Ranking <- as.numeric(GDP$Ranking)

dat2 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                      destfile = "./Getting and Cleaning Data/data/educat.csv",
                      method = 'curl')

educat <- read.csv("./Getting and Cleaning Data/data/educat.csv", h=T, sep=",")

educat2 <- educat %>%
  select(1,3,6,10)

tog <- merge(GDP, educat2, by.x = c("Country"), by.y=c("CountryCode"))
tog2 <- tog[tog$Special.Notes==grep("(^Fiscal) * June", tog),]

tog <- arrange(tog,desc(Ranking))


### Question 5:

library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

sample2 <- sampleTimes[which(year(sampleTimes)==2012)]
length(sample2)

days <- sample2[which(weekdays(sample2)=="Monday")]
length(days)


