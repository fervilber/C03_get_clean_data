##########################################################################################################
## Coursera Getting and Cleaning Data Course Project
# File: run_analysis.R
# Date: 2016-12-12
# Author: Fervilber
##########################################################################################################

This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##############################

### preparing the material ###
# Set working directory
setwd("C:/R/proyectos/C3_course_project")

# Download data files
library(httr) 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "datos.zip"
if(!file.exists(file)){
    print("descargando")
    download.file(url, file, method = "wininet")
}

# Unzip and create folders 
datafolder <- "UCI_HAR_Dataset"
resultsfolder <- "results"
if(!file.exists(datafolder)){
    print("unzip file")
    unzip(file, list = FALSE, overwrite = TRUE)
} 

if(!file.exists(resultsfolder)){
    print("create results folder")
    dir.create(resultsfolder)
} 

# 0) Read txt and convert to data.frame in folder UCI HAR Dataset

setwd("C:/R/proyectos/C3_course_project/UCI HAR Dataset/")

# Read general data
features     = read.table('features.txt',header=FALSE); #imports features.txt
activityType = read.table('activity_labels.txt',header=FALSE); #imports activity_labels.txt

# Assigin column names to the data imported
colnames(activityType)  = c('activityId','activityType')


# Read data from train
subjectTrain = read.table('train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTrain       = read.table('train/X_train.txt',header=FALSE); #imports X_train.txt
yTrain       = read.table('train/y_train.txt',header=FALSE) #imports y_train.txt

# View data
# head(yTrain);head(xTrain);head(subjectTrain)
# dim(features)--> 561
# dim(xTrain)----> 561

# Assigin column names to the data imported above
colnames(subjectTrain)  = "subjectId"
colnames(xTrain)        = features[,2]
colnames(yTrain)        = "activityId"

# Create the final training set by merging yTrain, subjectTrain, and xTrain
trainingData = cbind(yTrain,subjectTrain,xTrain)

#str(trainingData)

# Read data from test
subjectTest = read.table('./test/subject_test.txt',header=FALSE) #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE) #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE) #imports y_test.txt

# As with train data:
# Assign column names to the test data 
colnames(subjectTest) = "subjectId"
colnames(xTest)       = features[,2]
colnames(yTest)       = "activityId"

# Create the final test set by merging the xTest, yTest and subjectTest data
testData = cbind(yTest,subjectTest,xTest)


#1) Merges the training and the test sets to create one data set

# Combine training and test data to create a final data set
# now row bind
finalData = rbind(trainingData,testData)

# Return to the principal folder
setwd("C:/R/proyectos/C3_course_project")

#2) Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_and_std <- finalData[,c(1,2,grep("std", colnames(finalData)), grep("mean", colnames(finalData)))]

# Function to save the resulting data in the indicated folder "results"
saveresults <- function (data,name){
    print(paste("saving results", name))
    file <- paste(resultsfolder, "/", name,".csv" ,sep="")
    write.csv(data,file)
}

saveresults(mean_and_std,"mean_and_std")

# 3. Use descriptive activity names to name the activities in the data set
# Merge the finalData set with the acitivityType table to include descriptive activity names

finalData = merge(finalData,activityType,by='activityId',all = TRUE)
unique(finalData[566])

#4) Appropriately labels the data set with descriptive variable names. 
# for that we review all names and special character and meke a function for cleaning

cleanName <- function (nameCol){
    nameCol = gsub("\\()","",nameCol)
    nameCol = gsub("-std$","StdDev",nameCol)
    nameCol = gsub("-mean","Mean",nameCol)
    nameCol = gsub("^(t)","time",nameCol)
    nameCol = gsub("^(f)","freq",nameCol)
    nameCol = gsub("([Gg]ravity)","Gravity",nameCol)
    nameCol = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",nameCol)
    nameCol = gsub("[Gg]yro","Gyro",nameCol)
    nameCol = gsub("AccMag","AccMagnitude",nameCol)
    nameCol = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",nameCol)
    nameCol = gsub("JerkMag","JerkMagnitude",nameCol)
    nameCol = gsub("GyroMag","GyroMagnitude",nameCol)
}

colnames(finalData)<-lapply(colnames(finalData), cleanName)
tail(finalData[563:564])
# remove duplicate col activityType
finalData<-finalData[-c(564:565)]

#5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(plyr)

tidy_dataset <- ddply(mean_and_std, .(activityId, subjectId), .fun=function(x){ colMeans(x[,-c(1:2)]) })
colnames(tidy_dataset)[-c(1:2)] <- paste(colnames(tidy_dataset)[-c(1:2)], "_mean", sep="")
saveresults(tidy_dataset,"tidy_dataset")
