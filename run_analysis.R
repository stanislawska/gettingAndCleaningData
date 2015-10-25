library(dplyr)
library(stringr)

# Important! Replace the path below with the one on your system. It must point to the UCI HAR Dataset
yourWorkingDirectory <- "/home/maja/Courses/GettingAndCleaningData/UCI HAR Dataset" #replace this path
setwd(yourWorkingDirectory)

#Step 1: Read the files and add meaningful labels to them. Leave only columns that refer to means and standard deviations of measurements. Use descriptive activity names

#read activity labels file
activity_labels <- read.table("activity_labels.txt", header = FALSE, nrows = 6, col.names = c("activityID", "activityName"))

#read feature labels file
features <- read.table("features.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("id", "label"))#[[2]]
##remove bad characters from the feature labels
features <- mutate(features, "tidyLabel" = str_replace_all(label, "[,\\-()]", ""))
##leave only the tidy labels, prepared for naming data columns
features <- features[[3]]

# read and label test data files
testSubjects <- read.table("test/subject_test.txt", header = FALSE, nrows = 2947, col.names =c("subjectID") )

testLabels <- read.table("test/y_test.txt", header = FALSE, nrows = 2947, , col.names =c("activityID") )
##use descriptive activity names
testLabels <- left_join(testLabels, activity_labels, by = "activityID") 
testLabels <- select(testLabels, activityName)

testData <- read.table("test/X_test.txt", header = FALSE, nrows = 2947)
##label test data
colnames(testData) <- features
##extract only the measurements on the mean and standard deviation for each measurement
testData <- testData[,grep("mean|Mean|std|Std",features)]

# read training data files
trainSubjects <- read.table("train/subject_train.txt", header = FALSE, nrows = 7352, , col.names =c("subjectID") )

trainLabels <- read.table("train/y_train.txt", header = FALSE, nrows = 7352, col.names = c("activityID"))
##use descriptive activity names
trainLabels <- left_join(trainLabels, activity_labels, by = "activityID")
trainLabels <- select(trainLabels, activityName)

trainData <- read.table("train/X_train.txt", header = FALSE, nrows = 7352)
##label training data
colnames(trainData) <- features
##extract only the measurements on the mean and standard deviation for each measurement
trainData <- trainData[,grep("mean|Mean|std|Std",features)]

#Step 2. Merge the training and test data sets

#combine training and testing data, in this order
testDataSet <- cbind(testLabels, testSubjects, testData)
trainDataSet <- cbind(trainLabels, trainSubjects, trainData)
allData <- rbind(trainDataSet, testDataSet)

#Step 3. From the allData create a tidy data set with the average of each variable for each activity and each subject. Save it to a text file.

#group data by activity and subject, and calculate average values for each remaining measurement column
averagesForTidyData <- allData %>% group_by(activityName, subjectID) %>% summarise_each(funs(mean))

#save the tidy data from the last step as a text file using the write.table functions without row names
write.table(averagesForTidyData, file="tidyDataSet.txt", row.names = FALSE, col.names = TRUE)

#you can view the resulting tidyDataSet file by running those extra two lines of code
myTidyCheck <- read.table("tidyDataSet.txt", header = TRUE)
View(myTidyCheck)

