setwd("C:/Users/KSGI/Desktop/Data Science/Programming Assignement 3")


rankhospital <- function(state, outcome, num) {
  ## Read outcome data
  out <- read.csv("outcome-of-care-measures.csv", h=T, sep=",")
  
  ## Check that state and outcome are valid
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
    hosp4 <- data.frame(hosp3, Rank=c(1:nrow(hosp3)))
    colnames(hosp4) <- c("Hospital_Name", "State", outcome, "Rank")
    
    View(hosp4)
    
    if(num=="best") {
      best.h <- subset(hosp4, Rank==1)$Hospital_Name
      print(best.h)
    } else if (num=="worst") {
      last <- length(hosp4$Hospital_Name)
      worst.h <- subset(hosp4, Rank==last)$Hospital_Name
      print(worst.h)
    } else if (num > nrow(hosp4)) {
      hh <- NA
      print(hh)
    } else {
      
      hh <- subset(hosp4, Rank==num)$Hospital_Name
      print(hh)
    }
  }
}