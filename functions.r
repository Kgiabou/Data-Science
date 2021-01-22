columnmean  <- function(y, removeNA = TRUE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for (i in 1:nc)
  {
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means  
}

pollutantmean <- function(folder, pm, id){
  
  setwd(paste("C:/Users/kgiab/Desktop/DataScience/rprog_data_specdata/", folder, sep=""))
  
  files <- list.files(pattern = ".csv")
  means <- as.vector(NULL)
  
  
  for (i in id){
    
    monitor <- read.csv(files[i], h = TRUE, sep=",")
    me <- mean(monitor[, pm], na.rm = TRUE)
    means <- c(means, me)
    
  }
  print(means)
  
}
pollutantmean(folder="specdata", "sulfate", 1:10)
pollutantmean(folder="specdata", "nitrate", 73:99)

library(gtools)

complete <- function(folder, id){
  setwd(paste("C:/Users/kgiab/Desktop/DataScience/rprog_data_specdata/", folder, sep=""))
  
  files <- list.files(pattern = ".csv")
  
  for (i in id){
    
    monitor <- read.csv(files[i], h = TRUE, sep=",")
    comple <- complete.cases(monitor)
    data <- data.frame(id=i, nobs=sum(comple))
    assign(paste("data_", i, sep=""), data)
    
  }
  ll <- mixedsort(ls(pattern="data_"))
  ll_1 <- lapply(ll, get)
  comp <- do.call(rbind, ll_1)
  print(comp)
  rm(list = ls(pattern="data_"))
  
}

complete(folder = "specdata", id = 30:25)

thres <- function(folder, threshold=0){
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