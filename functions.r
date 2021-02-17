columnmean  <- function(y, removeNA = TRUE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for (i in 1:nc)
  {
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means  
}

pollutantmean <- function(folder, pm, id=1:322){
  
  setwd(paste("C:/Users/KSGI/Desktop/Data Science/specdata/", folder, sep=""))
  
  files <- list.files(pattern = ".csv")
  fil <- lapply(files, read.csv, h=T, sep=",")
  final <- do.call(rbind, fil)
    
    monitor <- subset(final, subset=ID %in% id)
    df <- data.frame(na.omit(monitor))
    
    mm <- mean(df[,pm]) 
    print(round(mm,3))
  
}
pollutantmean(folder="specdata", pm ="sulfate", id = c(1:10))

library(gtools)

complete <- function(folder, id=1:322){
  setwd(paste("C:/Users/KSGI/Desktop/Data Science/specdata/", folder, sep=""))
  
  files <- list.files(pattern = ".csv")
  fil <- lapply(files, read.csv, h=T, sep=",")
  final <- do.call(rbind, fil)
  nobs <- numeric()
  
  for (i in id)
  {  
      monitor <- final[which(final$ID==i),]
      comple <- complete.cases(monitor)
      com <- sum(comple)
      nobs <- c(nobs, com)
  }
  df1 <- data.frame(id, nobs)
  df1
}

complete(folder = "specdata", id = 30:25)

corr <- function(folder, threshold=0){
  setwd(paste0("C:/Users/KSGI/Desktop/Data Science/specdata/", folder, sep=""))
  
  files <- list.files(pattern = ".csv")
  fil <- lapply(files, read.csv, h=T, sep=",")
  final <- do.call(rbind, fil)
  
  vcor <- numeric()
  
  for (i in 1:length(unique(final$ID))){
    
    co <- na.omit(final[which(final$ID==i),])
    
    if(nrow(co) > threshold) {
      cors <- cor(co$sulfate, co$nitrate)
      vcor <- c(vcor, cors)
    }
    
  }
  print(vcor)
}

<<<<<<< HEAD
=======
# How to use split and apply functions ##
library(datasets)
head(iris)
fac <- split(iris, iris$Species)

ss <- lapply(fac, function (x) colMeans(x[, c()]))

#invisible(x) <- # prevents autoprinting of a functions last argument


fileurl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

fil <- xmlTreeParse(fileurl, useInternalNodes = TRUE)

rootNode <- xmlRoot(fil)
xmlName(rootNode)
xs <-xpathSApply(rootNode, "//name", xmlValue)

length(xs[xs==21231])

###Dplyr funtcions ##
by_package <- group_by(cran, package)

pack_sum <- summarize(by_package,
                      count =n() ,
                      unique = n_distinct(ip_id),
                      countries =n_distinct(country) ,
                      avg_bytes = mean(size))

quantile(pack_sum$count, probs=0.99)

top_counts <- filter(pack_sum, count >679)
top_counts_sorted <- arrange(top_counts, desc(count))

top_unique <- filter(pack_sum, unique >465)
top_unique_sorted <- arrange(top_unique, desc(unique))


