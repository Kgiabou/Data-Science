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

