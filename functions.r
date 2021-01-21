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