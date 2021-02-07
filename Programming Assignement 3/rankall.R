setwd("C:/Users/KSGI/Desktop/Data Science/Programming Assignement 3")


rankall <- function(outcome, num) {
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
  
  st <- unique(hosp$State)
  all_h <- NULL
    for (s in seq_along(st))
    {
      hosp2 <- subset(hosp, State==st[s])
      suppressWarnings(hosp2[,3] <-as.numeric(hosp2[,3]))
      hosp2 <- na.omit(hosp2)
      hosp3 <-  hosp2[with(hosp2, order(hosp2[,3], hosp2[,1])),]
      hosp4 <- data.frame(hosp3, Rank=c(1:nrow(hosp3)))
      maxim <- nrow(hosp4)
      colnames(hosp4) <- c("hospital", "state", outcome, "Rank")
     
      
      if(num=="best") {
        hh <- subset(hosp4, Rank==1)
        hh2 <- hh[,c("hospital", "state")]
       
      } else if (num=="worst") {
        last <- length(hosp4$hospital)
        hh <- subset(hosp4, Rank==last)
        hh2 <- hh[,c("hospital", "state")]
        
      }  else if (num > maxim) {
          hh <- hosp4
          hh$hospital <- NA
          hh2 <- hh[1, c("hospital", "state")]
      }
      
      else {
        hh <- subset(hosp4, Rank==num)
        hh2 <- hh[,c("hospital", "state")]
      }
      
      all_h <- rbind(all_h, hh2)
      rownames(all_h) <- NULL
    }
      return(all_h)
  
  }
