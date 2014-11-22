library(dplyr)
library(reshape2)

#Read column names and extract the ones with "mean" or "std" in their names
#Used later to get only the required columns
column_names <- read.table("UCI HAR Dataset/features.txt")
mean_column_names <- grepl(column_names[,2], pattern = "mean", ignore.case = F)
std_column_names <- grepl(column_names[,2], pattern = "std", ignore.case = F)

#Read activity labels
activity_lables <- read.table("UCI HAR Dataset/activity_labels.txt")


#read training set, subjects of trainig set ,and labels of training set
train_in <- read.table(file = "UCI HAR Dataset/train/X_train.txt", header = F)
names(train_in) <- column_names$V2
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = F,col.names = c("subject"))
label_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = F,col.names = c("activityid"))
train <- cbind(subject_train, label_train, train_in)

#read test set, subjects of test set ,and labels of test set
test_in <- read.table(file = "UCI HAR Dataset/test/X_test.txt", header = F)
names(test_in) <- column_names$V2
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
merged$activityid <- factor(merged$activityid, labels = activity_lables$V2)
colnames(merged)[2] <- "activity"



#4.Appropriately labels the data set with descriptive variable names.
#Using style similar to Google's R Style Guide: https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
all.names <- names(merged)
#use . instead of camelCase, and replace "t" with "time"
all.names <- gsub(pattern = "tBody", replacement = "time.body", x=all.names)
all.names <- gsub(pattern = "tGravity", replacement = "time.gravity", x=all.names)
#use . instead of camelCase, and replace "f" with "frequency"
all.names <- gsub(pattern = "fBody", replacement = "frequency.body", x=all.names) #
#replace bodyBody with "body"
all.names <- gsub(pattern = "bodyBody", replacement = "body", x=all.names)
#replace abbreviations
all.names <- gsub(pattern = "Gyro", replacement = ".gyroscope", x=all.names)
all.names <- gsub(pattern = "Jerk", replacement = ".jerk", x=all.names)
all.names <- gsub(pattern = "Mag", replacement = ".magnitude", x=all.names)
all.names <- gsub(pattern = "Acc", replacement = ".acceleration", x=all.names)
#replace special characters
all.names <- gsub(pattern = "\\(\\)", replacement = "", x=all.names)
all.names <- gsub(pattern = "-", replacement = ".", x=all.names)
all.names <- gsub(pattern = "meanFreq", replacement = "mean.frequecy", x=all.names)
#all lower case
all.names <- tolower(all.names)
names(merged) <- all.names


#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
melted <- melt(merged, id=c("subject","activity"), measure.vars = all.names[3:81])
melted.group <- group_by(melted, subject, activity, variable)
result <- summarise(melted.group, mean(value))
names(result) <- c("subject","activity","variable","mean")
write.table(result, file = "result.txt",row.name=FALSE)


