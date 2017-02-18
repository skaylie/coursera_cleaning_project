
#get file, unzip it and load it
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "raw_data.zip")

library(dplyr)

test_data <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/X_test.txt"), nrows=50, header=F, quote="\"", sep="")
train_data <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/X_train.txt"), nrows=50, header=F, quote="\"", sep="")

test_subjects <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/subject_test.txt"), nrows=50, header=F, quote="\"", sep="")
train_subjects <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/subject_train.txt"), nrows=50, header=F, quote="\"", sep="")

test_activities <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/y_test.txt"), nrows=50, header=F, quote="\"", sep="")
train_activities <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/y_train.txt"), nrows=50, header=F, quote="\"", sep="")

activity_labels <- read.table(unz("raw_data.zip", "UCI HAR Dataset/activity_labels.txt"), nrows=50, header=F, quote="\"", sep="")
names(activity_labels) <- c("activity_num", "activity_name")

#bind subject and activity columns to raw data for both test and train data sets
test_data <- cbind(test_subjects, test_data)
test_data <- cbind(test_activities, test_data)

train_data <- cbind(train_subjects, train_data)
train_data <- cbind(train_activities, train_data)

raw_data <- rbind(test_data, train_data)

#get and add data labels
data_labels <- read.table(unz("raw_data.zip", "UCI HAR Dataset/features.txt"), header=F, quote="\"", sep=" ")
names(raw_data) <- c("activity_num", "subject", gsub(pattern="[()]", replacement="", x = data_labels[,2]))

raw_data <- select(raw_data, c(activity, subject, grep("mean|std", names(raw_data)))) #select cols with mean and std in name

joined <- merge(activity_labels, raw_data, by.x = "activity_num", by.y = "activity_num") #join activity labels to raw_data
final_output <- joined %>% group_by(activity_name, subject) %>% summarize_each(funs(mean)) # output dataset with mean of each activity_name, subject for every variable