# Codebook

## Reading in the test and train data
### This part of the code is used to read in the test and train data
* subject_test : subject IDs for test

* subject_train : subject IDs for train

* X_test : values of variables in test

* X_train : values of variables in train

* y_test : activity ID in test

* y_train : activity ID in train

* activity_labels : Description of activity IDs in y_test and y_train

* features : description(label) of each variables in X_test and X_train

## 1. Merges the training and the test sets to create one data set

* data : bind of X_train and X_test

## 2. Extracts only the measurements on the mean and standard deviation for each measurement

* MeanAndSD: Code used to extract on the column names that correspond to a mean or standard Dev calculation

## 3. Uses descriptive activity names to name the activities in the data set
* Replacing the activity number with a descriptive string

# 4. Appropriately labels the data set with descriptive variable names
*Code removes brackets from the feature names

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
*"melts" data to be grouped by subject and activity and calculates mean of each value for each activity and each subject