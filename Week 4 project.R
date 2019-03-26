

fileName <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification. If file does not exist, download to working directory.
if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb") 
}

# File unzip verification. If the directory does not exist, unzip the downloaded file.
if(!file.exists(dir)){
  unzip("UCIdata.zip", files = NULL, exdir=".")
}
#Reading in the test and train data
subject_test <- read.table("./test/subject_test.txt")
subject_train <- read.table("./train/subject_train.txt")
X_test<-read.table("./test/X_test.txt")
X_train<-read.table("./train/X_train.txt")
y_test<-read.table("./test/y_test.txt")
y_train<-read.table("./train/y_train.txt")

#Read in activitiy and features data
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")  

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
# 1. Merges the training and the test sets to create one data set
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
data<-rbind(X_train,X_test)

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
MeanAndSD<- grep("mean()|std()", features[, 2]) 

data<-data[,MeanAndSD]

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
# 4. Appropriately labels the data set with descriptive variable names
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
CleanFeatureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(data) <- CleanFeatureNames[MeanAndSD]


subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(y_train, y_test)
names(activity) <- 'activity'

data<- cbind(subject,activity, data)
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
# 3. Uses descriptive activity names to name the activities in the data set
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
activity_group <- factor(data$activity)
levels(activity_group) <- activity_labels[,2]
data$activity <- activity_group

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
basedata <- melt(data,(id.vars=c("subject","activity")))
data2 <- dcast(basedata, subject + activity ~ variable, mean)
names(data2)[-c(1:2)] <- paste("[mean of]" , names(data2)[-c(1:2)] )
write.table(data2, "tidy_data.txt", sep = ",")
