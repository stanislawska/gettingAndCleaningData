---
title: "CodeBook"
author: "maja_s"
date: "25 October 2015"
---
#Code book for the "Getting and Cleaning Data" course project

This code book that describes the variables, the data, and any transformations or work that you performed to clean up the data

###Source files, measurement variables and required packages
The data for the project can be obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data set and variables is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
You can  find the summary of the source file variables at the end of this Code Book.

Once downloaded, extract the files to a directory. Before you run the runAnalysis.R script, replace the path that points to the directory (yourWorkingDirectory) at the top of the script.

The script requires that you have installed **dplyr** and **stringr** packages.

####Variables used in this project
- **yourWorkingDirectory**: stores a path to the directory where the source data is located
- **features**: labels for the 561 features measured in the experiment

#####Test data
- **testData** 2947 obs.: measurement data, initially for 561 variables, later reduced to 86 variables with mean and standard deviations only
- **testDataSet** 2947 obs. of 88 var.: combined test data set 
- **testLabels** 2947 obs. of 1 var.: activity labels
- **testSubjects** 2947 obs. of 1 var.: subject(personal) identification numbers

#####Training data
- **trainData** 7352 obs. of 86 var.: measurement data, initially for 561 variables, later reduced to 86 variables with mean and standard deviations only
- **trainDataSet** 7352 obs. of 88 var.: combined training data set
- **trainLabels** 7352 obs. of 1 var.: activity labels
- **trainSubjects** 7352 obs. of 1 var.: subject(personal) identification numbers

#####Activity lookup table
- **activity_labels** 6 obs. of 2 var. (activityID and activityName): activity lookup table

#####Data sets produced by the script
- **allData** 10299 obs. of 88 var.: data set resulting from fulfilling **project goals 1 through 4**, the first 7352 rows are from the training data set, the remaining 2947 rows are from the test data set; the first two columns identify the subject and the activity, the remaining 86 columns identify the measured features

- **averagesForTidyData** 180 obs. of 88 var.: tidy data set fulfilling project **goal 5**

###Goals of the project 
*In brackets steps in which the goal is achieved*
1. Merges the training and the test sets to create one data set. (step 2)
2. Extracts only the measurements on the mean and standard deviation for each measurement. (step 1)
3. Uses descriptive activity names to name the activities in the data set.  (step 1)
4. Appropriately labels the data set with descriptive variable names.  (step 1)
5. From the data set in stage 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  (step 3)

Note that the script achieves the goals in the following order: goal 4 => goal 2 => goal 3 => goal 1 => goal 5.

###How the goals are achieved using the run_analysis.R script

####Step 1: Read the files and add meaningful labels to them. Leave only columns that refer to means and standard deviations of measurements.
**This stage fulfills goals 2 through 4.**

The following source files are read using the read.table function:

- **activity_labels.txt**: activity lookup table
- **features.txt**: labels for the measurements
- **test/subject_test.txt**: subject identification numbers
- **test/y_test.txt**: labels for activities
- **test/X_test.txt**: measurement data
- **train/subject_train.txt**: subject identification numbers
- **train/y_train.txt**: labels for activities
- **train/X_train.txt**: measurement data

The features.txt file contains labels for measurements that are later to be used as column headers for the measurement data. The label strings contain problematic characters (brackets, hyphens, commas), so they are removed. Only the tidy label column is used later on. **Goal 4 is achieved.**

After adding the tidied labels to the measurement data columns, only columns refering to the mean and standard deviations are extracted (these are 86 variables out of the original 561). **Goal 2 is achieved.**

Numeric labels of activities in the measurement files (*X_test.txt* and *X_train.txt*) are replaced with descriptive strings using the lookup table contained in the activity_labels.txt file. **Goal 3 is achieved.**

####Step 2. Merge the training and test data sets

**Goal 1 is achieved.**
The training data and test data are combined to form one coherent data set with labels. 

####Step 3. From the allData create a tidy data set with the average of each variable for each activity and each subject. Save it to a text file. 

**Goal 5 is achieved.**

First, data set resulting from Step 2 is grouped by activity and by subject. Next, average for each measurement column is calculated.

Finally, the new tidy data set is saved to a file using the write.table function without row names. Note that all numeric variables in this data set contain average values for a given activity and a given subject (as per project requirements).

Additionally, the script contains two lines of code that allow to read the resulting text file and view its contents.

### Original variables from the source data
This is an excerpt from the *features_info.txt* file from the original data set

> Feature Selection 
> =================

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

> The set of variables that were estimated from these signals are: 

- mean(): Mean value **These values are included in the final tidy data set**
- std(): Standard deviation **These values are included in the final tidy data set**
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean



