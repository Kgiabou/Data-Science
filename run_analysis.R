library(tidyverse)

setwd("./Getting and Cleaning Data/")

if(!file.exists("Course Assignement")){
        dir.create("Course Assignment")
}

data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile = "./Course Assignment/wearable.zip",
                      method = "curl")


data2<- unzip("./Course Assignment/wearable.zip", files=NULL, exdir = "./Course Assignment")

setwd("./Course Assignment/UCI HAR Dataset")

X_train <- as_tibble(read.table("./train/X_train.txt"))
y_train <- read.table("./train/y_train.txt")
s_train <- read.table("./train/subject_train.txt") %>%
           rename(Subjects=V1)

X_test <- as_tibble(read.table("./test/X_test.txt"))
y_test <- read.table("./test/y_test.txt")
s_test <- read.table("./test/subject_test.txt") %>%
          rename(Subjects=V1)


activity <- read.table("activity_labels.txt") 
y_train2 <- merge(y_train, activity, by="V1")
y_test2 <- merge(y_test, activity, by="V1")

feature <- read.table("features.txt") %>%
           rename(Features=V2)

colnames(X_train)  <- as.vector(feature$Features)
colnames(X_test)  <- as.vector(feature$Features)


Atrain <- cbind(s_train, Activity=y_train2[,2], X_train) 
Atest  <- cbind(s_test, Activity=y_test2[,2], X_test)



all_data <- rbind(Atrain, Atest)

cols <- which(grepl("mean|std.*", colnames(all_data)))
all_d <- all_data[,c(1,2,cols)]

colnames(all_d) <- gsub("[()]", "", colnames(all_d))
all_d$Activity <- as.factor(all_d$Activity)

library(reshape2)


longData <- melt(all_d, id.vars = c("Subjects", "Activity"), na.rm = TRUE)

avData <- dcast(longData, Subjects + Activity ~ variable, fun=mean)


