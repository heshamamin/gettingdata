Introduction
------------
This code book describes the tall tidy dataset generated using the steps described in README.md.

Description
-------------------
The data is a result of mering the training and test datasets from the source "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" which is described at "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

The selected variables from the original dataset are the subject id, the activity, and the mean and standard deviation for each measurement.
This tall dataset contains the average value of each variable for each activity and each subject. 
Varible names are altered to match Google's R Style Guide: "https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml"

Code Book
---------
These are the columns of the dataset:
- subject: The id of the subject, integer value from 1 : 30
- activity: The name of the meassured activity, possible values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING. Which are extracted from "UCI HAR Dataset/activity_labels.txt"
- variable: The name of the variable extracted from the datasets. The name is changed to adhere to Google's R Style Guide.
- mean: The average of the variable with respect to subject and activity.
