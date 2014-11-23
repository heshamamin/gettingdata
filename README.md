gettingdata
===========

Introduction
------------
This file explains the steps to create the processed tidy dataset.

Steps:
-----
1. Download data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the downloaded zip file using any compression utility. Now you should have the "UCI HAR Dataset" folder which contains the data.
3. Place the "run_analysis.R" file at the same level as the "UCI HAR Dataset" folder. The R file referenes the data files using the format: "UCI HAR Dataset/file.ext"
4. In R, set the working directory to the path of the directory that contains "run_analysis.R" and "UCI HAR Dataset". Use setwd("path_to_directory") to do so.
5. Source the "run_analysis.R" using source("run_analysis.R")
6. The script will generate the "result.txt" file in the working directory. This file is the output tidy dataset.

Code Book
---------
Refer to CodeBook.md for details.
