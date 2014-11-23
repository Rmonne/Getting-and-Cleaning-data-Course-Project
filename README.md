Getting-and-Cleaning-data-Course-Project
========================================
README

In the light of the project for the Coursera course ‘Getting and cleaning data’ i performed an analysis to make a specified dataset tidy-er.

The script has several steps, each described in detail below:

First the script loads al required files in memory. This leads to the following list: 
X_train —> containing all measurements from the mobile phone in the training set.
y_train —> containing all labels from the mobile phone in the training set.
X_test —> containing all measurements from the mobile phone in the test set
y_test —> containing all measurements from the mobile phone in the test set.
features —> containing all features which are used for the column names of the measurements
subject_test —> contains the ID of the subject performing the activities in the training set
subject_train —> contains the ID of the subject performing the activities in the test set

after this I combine the measurement, label and subject data from the test and training set. (by using the function cbind() )

then the training and test set need to be merged, this is done by rbind() (requisite 1)

then we create a vector from the feature list and give all columns a name (also labeling the columns with “activity” and “subject) (requisite 4)

now we have a complete dataset with descriptive columnnames, now we need to transform the numbers in the activity column to more descriptive character strings. This action is performed while creating a new column and setting the values to the needed string. every activity of the subject now has a descriptive name like: WALKING (requisite 3)

there are a lot of columns in the dataset that we don’t need, so we perform a select-command to select all columns with either ‘mean’ or ‘std’ mentioned in the columnname, and the two columns: subject and activitynames (which is created in the step before)

since we have a lot of temporal datasets, we remove all that we don’t need by the remove command

after this we have the data set that we need to perform the last step in the requirements.

We now create a melted dataset, which is required for the casting of the dataset in the last step. A melted dataset is a very narrow dataset where the values of the columns are transferred to the rows. We select the variables that are required for the tidy dataset (subject, activityname, and all measurement values)

at last we create the data set which is required, by casting the melted dataset in the form we need. we use the factors subject and activitynames to create the overview we want. we also incorporate the mean function in the call to make sure we get the mean of all measurement values per subject, per activty.

after this we return the tidy dataset
