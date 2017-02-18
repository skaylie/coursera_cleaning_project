
#get file, unzip it and load it
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "raw_data.zip")

test_data <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/X_test.txt"), header=F, quote="\"", sep="")
train_data <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/X_train.txt"), header=F, quote="\"", sep="")

test_subjects <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/subject_test.txt"), header=F, quote="\"", sep="")
train_subjects <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/subject_train.txt"), header=F, quote="\"", sep="")

test_activities <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/y_test.txt"), header=F, quote="\"", sep="")
train_activities <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/y_train.txt"), header=F, quote="\"", sep="")

activity_labels <- read.table(unz("raw_data.zip", "UCI HAR Dataset/activity_labels.txt"), header=F, quote="\"", sep="")
names(activity_labels) <- c("activity_num", "activity_name")

#bind subject and activity columns to raw data for both test and train data sets
test_data <- cbind(test_subjects, test_data)
test_data <- cbind(test_activities, test_data)

train_data <- cbind(train_subjects, train_data)
train_data <- cbind(train_activities, train_data)

raw_data <- rbind(test_data, train_data)

#get and add data labels
data_labels <- read.table(unz("raw_data.zip", "UCI HAR Dataset/features.txt"), header=F, quote="\"", sep=" ")
names(raw_data) <- c("activity_num", "subject_num", gsub(pattern="[()]", replacement="", x = data_labels[,2]))

#remove columns with duplicate names and keep only columns with mean and std in name
raw_data <- raw_data[,!duplicated(names(raw_data))]
cols_to_keep <- c(1, 2, grep("mean|std", names(raw_data))) 
raw_data <- raw_data[,cols_to_keep] 

#join activity labels to raw_data
joined <- merge(activity_labels, raw_data, by.x = "activity_num", by.y = "activity_num") 
library(dplyr)
#create and save output dataset with mean of each activity_name, subject for every variable
final_output <- joined %>% group_by(activity_name, subject_num) %>% summarize_each(funs(mean)) 
write.table(final_output, file="output.txt", row.names = FALSE)