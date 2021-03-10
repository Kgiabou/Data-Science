## Question 1:

dat <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                      destfile = "./Getting and Cleaning Data/data/commun.csv",
                      method = 'curl')

coms <- read.csv("./Getting and Cleaning Data/data/commun.csv")

agricultureLogical <- coms$AGS==6 & coms$ACR==3
which(agricultureLogical)

##Question 2:
library(jpeg)
dat <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
                     destfile = "./Getting and Cleaning Data/data/leek.jpg",
                     method = 'curl')

pic <- readJPEG(source = "./Getting and Cleaning Data/data/leek.jpg", native = TRUE)

qu <- quantile(pic, probs = c(0.3,0.8))

##Question 3:

dat <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv ",
                     destfile = "./Getting and Cleaning Data/data/GDP.csv",
                     method = 'curl')

GDP <- read.csv2("./Getting and Cleaning Data/data/GDP.csv", sep=",", skip = 3)
GDP <- GDP %>%
  as_tibble %>%
  select(1,2,4,5) %>%
  rename(Country=X, USD=US.dollars.)

GDP <-  GDP[c(2:191),] 
GDP$Ranking <- as.numeric(GDP$Ranking)
  
dat2 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ",
                      destfile = "./Getting and Cleaning Data/data/educat.csv",
                      method = 'curl')

educat <- read.csv("./Getting and Cleaning Data/data/educat.csv", h=T, sep=",")

educat2 <- educat %>%
  select(1,3,6)

tog <- merge(GDP, educat2, by.x = c("Country"), by.y=c("CountryCode"))
tog <- arrange(tog,desc(Ranking))

IDs <- nrow(tog)
C.13 <- tog[13,]

### Question 4:

f <- split(tog$Ranking, as.factor(tog$Income.Group))
f2 <- sapply(f, mean) 

### Question 5:
tabs <- table(tog$Ranking, tog$Income.Group)
colSums(tabs[1:38,])

