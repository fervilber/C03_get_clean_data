---
title: "CodeBook.md"
author: "fervilber"
date: "diciembre de 2016"
---
## Introduction

This documment is the codebook for the Getting and Cleaning Data Course Project. 
We have created 3 files with the results and R script of the exercise.

This files are: 

1. run_analysis.R.  
2. mean_and_std.csv 
3. tidy_dataset.csv

The first file contein the R code to get the resuts. The other two csv files contein the data that we have obtained.

## run_analysis.R
This file contains a summary of the steps followed in the code.


0. Download data and read txt files from train and test dir.
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finally we saves the mean and std into *mean_and_std.csv* and the tidy dataset into *tidy_dataset.csv*
s to create one data set.

## mean_and_std.csv 

This file contains 10299 rows and and 81 columns in a csv format.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

### The complete list of variables of each feature vector is:
* id
* activityId
* subjectId
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-std()
* tGravityAccMag-std()
* tBodyAccJerkMag-std()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-std()
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyAccMag-std()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-std()
* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyAccMag-mean()
* tGravityAccMag-mean()
* tBodyAccJerkMag-mean()
* tBodyGyroMag-mean()
* tBodyGyroJerkMag-mean()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-meanFreq()-X
* fBodyAcc-meanFreq()-Y
* fBodyAcc-meanFreq()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-meanFreq()-X
* fBodyAccJerk-meanFreq()-Y
* fBodyAccJerk-meanFreq()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-meanFreq()-X
* fBodyGyro-meanFreq()-Y
* fBodyGyro-meanFreq()-Z
* fBodyAccMag-mean()
* fBodyAccMag-meanFreq()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-meanFreq()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-meanFreq()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-meanFreq()

## tidy_dataset.csv

Contains 180 rows  and 81 columns in a csv format.
This table contains the mean value of each convination of activityId and subjectId.
* activityId
* subjectId
* tBodyAcc-std()-X_mean
* tBodyAcc-std()-Y_mean
* tBodyAcc-std()-Z_mean
* tGravityAcc-std()-X_mean
* tGravityAcc-std()-Y_mean
* tGravityAcc-std()-Z_mean
* tBodyAccJerk-std()-X_mean
* tBodyAccJerk-std()-Y_mean
* tBodyAccJerk-std()-Z_mean
* tBodyGyro-std()-X_mean
* tBodyGyro-std()-Y_mean
* tBodyGyro-std()-Z_mean
* tBodyGyroJerk-std()-X_mean
* tBodyGyroJerk-std()-Y_mean
* tBodyGyroJerk-std()-Z_mean
* tBodyAccMag-std()_mean
* tGravityAccMag-std()_mean
* tBodyAccJerkMag-std()_mean
* tBodyGyroMag-std()_mean
* tBodyGyroJerkMag-std()_mean
* fBodyAcc-std()-X_mean
* fBodyAcc-std()-Y_mean
* fBodyAcc-std()-Z_mean
* fBodyAccJerk-std()-X_mean
* fBodyAccJerk-std()-Y_mean
* fBodyAccJerk-std()-Z_mean
* fBodyGyro-std()-X_mean
* fBodyGyro-std()-Y_mean
* fBodyGyro-std()-Z_mean
* fBodyAccMag-std()_mean
* fBodyBodyAccJerkMag-std()_mean
* fBodyBodyGyroMag-std()_mean
* fBodyBodyGyroJerkMag-std()_mean
* tBodyAcc-mean()-X_mean
* tBodyAcc-mean()-Y_mean
* tBodyAcc-mean()-Z_mean
* tGravityAcc-mean()-X_mean
* tGravityAcc-mean()-Y_mean
* tGravityAcc-mean()-Z_mean
* tBodyAccJerk-mean()-X_mean
* tBodyAccJerk-mean()-Y_mean
* tBodyAccJerk-mean()-Z_mean
* tBodyGyro-mean()-X_mean
* tBodyGyro-mean()-Y_mean
* tBodyGyro-mean()-Z_mean
* tBodyGyroJerk-mean()-X_mean
* tBodyGyroJerk-mean()-Y_mean
* tBodyGyroJerk-mean()-Z_mean
* tBodyAccMag-mean()_mean
* tGravityAccMag-mean()_mean
* tBodyAccJerkMag-mean()_mean
* tBodyGyroMag-mean()_mean
* tBodyGyroJerkMag-mean()_mean
* fBodyAcc-mean()-X_mean
* fBodyAcc-mean()-Y_mean
* fBodyAcc-mean()-Z_mean
* fBodyAcc-meanFreq()-X_mean
* fBodyAcc-meanFreq()-Y_mean
* fBodyAcc-meanFreq()-Z_mean
* fBodyAccJerk-mean()-X_mean
* fBodyAccJerk-mean()-Y_mean
* fBodyAccJerk-mean()-Z_mean
* fBodyAccJerk-meanFreq()-X_mean
* fBodyAccJerk-meanFreq()-Y_mean
* fBodyAccJerk-meanFreq()-Z_mean
* fBodyGyro-mean()-X_mean
* fBodyGyro-mean()-Y_mean
* fBodyGyro-mean()-Z_mean
* fBodyGyro-meanFreq()-X_mean
* fBodyGyro-meanFreq()-Y_mean
* fBodyGyro-meanFreq()-Z_mean
* fBodyAccMag-mean()_mean
* fBodyAccMag-meanFreq()_mean
* fBodyBodyAccJerkMag-mean()_mean
* fBodyBodyAccJerkMag-meanFreq()_mean
* fBodyBodyGyroMag-mean()_mean
* fBodyBodyGyroMag-meanFreq()_mean
* fBodyBodyGyroJerkMag-mean()_mean
* fBodyBodyGyroJerkMag-meanFreq()_mean

