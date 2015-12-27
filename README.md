#Getting and cleaning data
download link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#Files available

README.md -- Description of the files and script

CodeBook.md -- codebook describing variables, the data and transformations

run_analysis.R -- Main script for the project

#Project Instructions

You should create one R script called run_analysis.R that does the following. 
 
  Merges the training and the test sets to create one data set.
  
  Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  Uses descriptive activity names to name the activities in the data set
  
  Appropriately labels the data set with descriptive variable names. 
  
  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Steps

1) Download file and unzip it into local directory

2) Filter data for only variables that contain mean and std measurements forboth train and test data sets

3) Read and assign labels to Train and Test data sets

4) Merge Train and Test Data sets

5) Apply transformations using melt and dcast functions for only mean values

6) Write the resulting file to tidy_data.txt


