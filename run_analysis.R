#import data table library used by this script
library(data.table)

#Read column names and extract the ones with "mean" or "std" in their names
#Used later to get only the required columns
column_names <- read.table("UCI HAR Dataset/features.txt")
mean_column_names <- grepl(column_names[,2], pattern = "mean", ignore.case = F)
std_column_names <- grepl(column_names[,2], pattern = "std", ignore.case = F)

#Read activity labels
activity_lables <- read.table("UCI HAR Dataset/activity_labels.txt")


#read training set, subjects of trainig set ,and labels of training set
train_in <- read.table(file = "UCI HAR Dataset/train/X_train.txt", header = F)
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = F,col.names = c("subject"))
label_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = F,col.names = c("activityid"))
train <- cbind(subject_train, label_train, train_in)

#read test set, subjects of test set ,and labels of test set
test_in <- read.table(file = "UCI HAR Dataset/test/X_test.txt", header = F)
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = F,col.names = c("subject"))
label_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt", header = F,col.names = c("activityid"))
test <- cbind(subject_test, label_test, test_in)

#1.Merges the training and the test sets to create one data set.
merged_all <- rbind(train, test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#filter data according to column names obtained eariler
#but keep the firts two columns (subject, activityid)
merged <- merged_all[, c(T,T,mean_column_names | std_column_names)]

#3.Uses descriptive activity names to name the activities in the data set
merged$activity <- factor(merged$activityid, labels = activity_lables$V2)
merged$activityid <- NULL



#add subjects and labels to merged data sets, and convert to data table for next steps
merged_data <- cbind(merged_subjects, merged_lables, merged_data)
merged_data <- as.data.table(merged_data)

#add redable activity label names
merged_data <- merged_data[, activity:=activity_lables[activity_label_id,2]]

