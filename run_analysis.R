library(tidyr)

setwd("./Getting and Cleaning Data/")

if(!file.exists("Course Assignement")){
        dir.create("Course Assignment")
}

data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile = "./Course Assignment/wearable.zip",
                      method = "curl")


data2<- unzip("./Course Assignment/wearable.zip", exdir = "./Course Assignment/Assignment data")

setwd("./Course Assignment/Assignment data/UCI HAR Dataset")

Xtrain <- as_tibble(read.table("./train/X_train.txt"))
ytrain <- read.table("./train/y_train.txt")
subj_tr <- read.table("./train/subject_train.txt")

Xtest <- as_tibble(read.table("./test/X_test.txt"))
ytest <- read.table("./test/y_test.txt")
subj_test <- read.table("./test/subject_test.txt")

activ <- read.table("activity_labels.txt")

Xdata <- rbind(Xtrain, Xtest) 
ydata <- rbind(ytrain, ytest)

featur <- read.table("features.txt")
f_info <- read.table("features_info.txt")
