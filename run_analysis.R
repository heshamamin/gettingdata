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
train_raw <- read.table(file = "UCI HAR Dataset/train/X_train.txt", header = F)
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = F)
label_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = F)

#read test set, subjects of test set ,and labels of test set
test_raw <- read.table(file = "UCI HAR Dataset/test/X_test.txt", header = F)
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = F)
label_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt", header = F)

#merge data sets
merged_data <- rbind(train_raw, test_raw)

#merge subject and labels, give their columns a nice name before adding to the merged data set
merged_subjects <- rbind(subject_train, subject_test); names(merged_subjects) <- "subjcets"
merged_lables <- rbind(label_train, label_test); names(merged_lables) <- "activity_label_id"

#filter data according to column names obtained eariler
merged_data <- merged_data[, mean_column_names | std_column_names]

#add subjects and labels to merged data sets, and convert to data table for next steps
merged_data <- cbind(merged_subjects, merged_lables, merged_data)
merged_data <- as.data.table(merged_data)

#add redable activity label names
merged_data <- merged_data[, activity:=activity_lables[activity_label_id,2]]

