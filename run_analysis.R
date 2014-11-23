## reading in data
X_test <- read.table("~/Dropbox/Prive/Master/DataScience/GettingandCleaningDataProject/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/Dropbox/Prive/Master/DataScience/GettingandCleaningDataProject/UCI HAR Dataset/test/y_test.txt")
X_train <- read.table("~/Dropbox/Prive/Master/DataScience/GettingandCleaningDataProject/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/Dropbox/Prive/Master/DataScience/GettingandCleaningDataProject/UCI HAR Dataset/train/y_train.txt")
features <- read.table("~/Dropbox/Prive/Master/DataScience/GettingandCleaningDataProject/UCI HAR Dataset/features.txt")
subject_test <- read.table("~/Dropbox/Prive/Master/DataScience/GettingandCleaningDataProject/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("~/Dropbox/Prive/Master/DataScience/GettingandCleaningDataProject/UCI HAR Dataset/train/subject_train.txt")

# merging labels, subjects and training and test measurements (requisite 1)
test <- cbind(subject_test, X_test, y_test)
train <- cbind(subject_train, X_train, y_train)

#merging test and training data (requisite 1)
alldata <- rbind(test, train)

#setting columnnames to more descriptive names (using the feature names of the dataset) (requisite 4)
#(first is subject, then all featurenames, then activity)
colnamesfeatures <- make.names(as.character(features[,2]), unique = T)
colnames(alldata) <- c("activity", colnamesfeatures, "subject")


##creating nice labels for activity names in a new column (requisite 3)
alldata$activitynames[alldata[["activity"]] == 1] <- "WALKING"
alldata$activitynames[alldata[["activity"]] == 2] <- "WALKING_UPSTAIRS"
alldata$activitynames[alldata[["activity"]] == 3] <- "WALKING_DOWNSTAIRS"
alldata$activitynames[alldata[["activity"]] == 4] <- "SITTING"
alldata$activitynames[alldata[["activity"]] == 5] <- "STANDING"
alldata$activitynames[alldata[["activity"]] == 6] <- "LAYING"
  
#select all data that is either mean or std (and select subject and activitynames) (requisite 2)
#installing the required package dplyr for this action
install.packages("dplyr")
library(dplyr)
alldata <- select(alldata, subject, contains("mean"), contains("std"), activitynames)

#removes all not needed temporal objects
rm(train, test, features, activity_labels, X_test, y_test, X_train, y_train, subject_test, subject_train, colnamesfeatures)

#creating the tidy dataset of requisite 5
library (reshape2)
melted <- melt(alldata, id=c("subject", "activitynames"), measure.vars=colnames(alldata[,2:87]))
tidy <- dcast(melted, subject + activitynames ~ variable, mean)

return(tidy)
