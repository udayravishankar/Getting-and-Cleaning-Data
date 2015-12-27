#install required shaping  packages
install.packages("reshape2")
install.packages("data.table")

#load library
library(reshape2)
library(data.table)

#download zip file into data folder created in working directory
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(file.exists("./data")){dir.create("./data")}
download.file(fileurl,destfile = "./data/courseproject.zip")


#extract zip file to data folder created in working directory
unzip("./data/courseproject.zip",exdir = "./data/Courseproject")


#read activity labels
activitylabels <- read.table(".\\data\\Courseproject\\UCI HAR Dataset\\activity_labels.txt")[,2]

#read features
features <- read.table(".\\data\\Courseproject\\UCI HAR Dataset\\features.txt")[,2]


#Extracts only measurements on the mean and standard deviation for each measuremen
extracted_features <- grepl("mean|std", features)

#read the subjects
subject_test_data <- read.table(".\\data\\Courseproject\\UCI HAR Dataset\\test\\subject_test.txt")

#read data 
x_test_data <- read.table(".\\data\\Courseproject\\UCI HAR Dataset\\test\\X_test.txt")

#read test labels
y_test_data <-  read.table(".\\data\\Courseproject\\UCI HAR Dataset\\test\\y_test.txt")

#set the coloumn names for test data and map class labels to data 
names(x_test_data) = features
x_test_data = x_test_data[,extract_features]
y_test_data[,2] = activitylabels[y_test_data[,1]]
names(y_test_data) = c("Activity_ID", "Activity_Label")
names(subject_test_data) = "subject"

#bind test data
test_data <- cbind(as.data.table(subject_test_data), y_test_data,x_test_data)


#read subjects train data
subject_train_data <- read.table(".\\data\\Courseproject\\UCI HAR Dataset\\train\\subject_train.txt")

#read train data
x_train_data <- read.table(".\\data\\Courseproject\\UCI HAR Dataset\\train\\X_train.txt")

#read train data labels
y_train_data <-  read.table(".\\data\\Courseproject\\UCI HAR Dataset\\train\\y_train.txt")

#set the coloumn names for test data and map class labels to data
names(x_train_data) = features
x_train_data = x_train_data[,extract_features]
y_train_data[,2] = activitylabels[y_train_data[,1]]
names(y_train_data) = c("Activity_ID", "Activity_Label")
names(subject_train_data) = "subject"


# Bind train data
train_data <- cbind(as.data.table(subject_train_data), y_train_data, x_train_data)


# Merge test and train data
final_data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)


#convert from wide to long format
melt_data  = melt(final_data, id = id_labels, measure.vars = data_labels)


# convert to wide format and apply mean
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)


write.table(tidy_data, file = "./data/tidy_data.txt", row.name=FALSE)

