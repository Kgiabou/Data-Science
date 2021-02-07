setwd("C:/Users/KSGI/Desktop/Data Science/Programming Assignement 3")

best <- function(state, outcome){
  out <- read.csv("outcome-of-care-measures.csv", h=T, sep=",")
  
  if(outcome=="heart attack") {
    hosp <- out[,c(which(colnames(out)=="Hospital.Name"), 
                   which(colnames(out)=="State"),
                   which(colnames(out)==names(out)[11]))]
    
  } else if (outcome=="heart failure") {
    hosp <- out[,c(which(colnames(out)=="Hospital.Name"), 
                   which(colnames(out)=="State"),
                   which(colnames(out)==names(out)[17]))]
    
  } else if (outcome=="pneumonia") {
    hosp <- out[,c(which(colnames(out)=="Hospital.Name"),
                   which(colnames(out)=="State"),
                   which(colnames(out)==names(out)[23]))]
   
  } else {
    stop ("invalid outcome")
  }
  
  '%notin%' <- Negate('%in%')
  
  if (state %notin% unique(hosp$State))  {
    stop("invalid state")
  } else {
    
    hosp2 <- subset(hosp, State==state)
    
    hosp2[,3] <-as.numeric(hosp2[,3])
    #If we want to suppress warning on NAs introduced by coercion#
    
    #suppressWarnings( hosp2[,3] <- as.numeric(hosp2[,3]))
    
    hosp2 <- na.omit(hosp2)
    hosp3 <-  hosp2[with(hosp2, order(hosp2[,3], hosp2[,1])),]
    colnames(hosp3) <- c("Hospital_Name", "State", outcome)
    
    best.h <- hosp3$Hospital_Name[1]
  }
  best.h
}