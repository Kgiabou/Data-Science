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


activity <- read.table("activity_labels.txt") %>%
            rename(Activity=V2)

feature <- read.table("features.txt") %>%
           rename(Features=V2)

colnames(X_train)  <- as.vector(featur$Features)
colnames(X_test)  <- as.vector(featur$Features)


Atrain <- cbind(s_train, y_train, X_train) 
Atest  <- cbind(s_test, y_test,X_test)

Atrain2 <- merge(activ, Atrain, by.x="V1", by.y="V1", all=FALSE) %>%
           select(-V1)

Atest <- 

  


View(Xdata)
