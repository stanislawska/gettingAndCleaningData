---
title: "CodeBook"
author: "maja_s"
date: "25 October 2015"
output: html_document
---
#Code book for the "Getting and Cleaning Data" course project

This code book that describes the variables, the data, and any transformations or work that you performed to clean up the data

##Source files, measurement variables and required packages
The data for the project can be obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data set and variables is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The variables are also described in the features_info.txt file in the data set.

Once downloaded, extract the files to a directory. Before you run the runAnalysis.R script, replace the path that points to the directory (yourWorkingDirectory) at the top of the script.

The script requires that you have installed dplyr and stringr packages.

###Goals of the project (in brackets steps in which the goal is achieved)
1. Merges the training and the test sets to create one data set. (step 2)
2. Extracts only the measurements on the mean and standard deviation for each measurement. (step 1)
3. Uses descriptive activity names to name the activities in the data set.  (step 1)
4. Appropriately labels the data set with descriptive variable names.  (step 1)
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  (step 3)

###How the goals are achieved using the run_analysis.R script

####Step 1: Read the files and add meaningful labels to them. Leave only columns that refer to means and standard deviations of measurements.
This stage fulfills goals 2 through 4.

The following files are read using the read.table function:

- activity_labels.txt
- features.txt
- test/subject_test.txt
- test/y_test.txt
- test/X_test.txt
- train/subject_train.txt
- train/y_train.txt
- train/X_train.txt

The features.txt file contains labels for measurements that are later to be used as column headers for the measurement data. The label strings contain problematic characters (brackets, hyphens, commas), so they are removed. Only the tidy label column is used later on.
After adding the tidied labels to the measurement data columns, only columns refering to the mean and standard deviations are extracted (these are 86 variables out of the original 561).

Numeric labels of activities in the measurement files ('X_test.txt' and 'X_train.txt') are replaced with descriptive strings using the lookup table contained in the activity_labels.txt file.

####Step 2. Merge the training and test data sets
The training data and test data are combined to form one coherent data set with labels.

####Step 3. From the allData create a tidy data set with the average of each variable for each activity and each subject. Save it to a text file.

First, data set resulting from Step 2 is grouped by activity and by subject. Next, average for each measurement column is calculated.

Finally, the new tidy data set is saved to a file using the write.table function without row names. Note that all numeric variables in this data set contain average values for a given activity and a given subject (as per project requirements).

Additionally, the script contains two lines of code that allow to read the resulting text file and view its contents.

