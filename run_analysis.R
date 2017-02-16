
#get file, unzip it and load it
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "raw_data.zip")

data_labels <- read.table(unz("raw_data.zip", "UCI HAR Dataset/features.txt"), header=F, quote="\"", sep=" ")
test_data <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/X_test.txt"), nrows=50, header=F, quote="\"", sep="")
train_data <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/X_train.txt"), nrows=50, header=F, quote="\"", sep="")

test_subjects <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/subject_test.txt"), nrows=50, header=F, quote="\"", sep="")
train_subjects <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/subject_train.txt"), nrows=50, header=F, quote="\"", sep="")

test_activities <- read.table(unz("raw_data.zip", "UCI HAR Dataset/test/y_test.txt"), nrows=50, header=F, quote="\"", sep="")
train_activities <- read.table(unz("raw_data.zip", "UCI HAR Dataset/train/y_train.txt"), nrows=50, header=F, quote="\"", sep="")

activity_labels <- read.table(unz("raw_data.zip", "UCI HAR Dataset/activity_labels.txt"), nrows=50, header=F, quote="\"", sep="")

#select and bind pertinent columns
test_narrow <- select(test_data, 1:6)
test_narrow <- cbind(test_subjects, test_narrow)
test_narrow <- cbind(test_activities, test_narrow)

train_narrow <- select(train_data, 1:6)
train_narrow <- cbind(test_subjects, test_narrow)
train_narrow <- cbind(test_activities, test_narrow)

raw_data <- rbind(test_narrow, train_narrow)
raw_data$observation <- 1:nrow(raw_data)
names(raw_data) <- gsub(pattern="[()]", replacement="", x = data_labels[1:6,2])

names(with_cols) <- c("subject", "activity", "acceleration_mean_x", "acceleration_mean_y", "acceleration_mean_z", "acceleration_std_dev_x", "acceleration_std_dev_y", "acceleration_std_dev_z")
joined <- merge(with_all, activity_labels, by.x = "activity", by.y = "V1")
molten <- melt(with_cols, id.vars=c("subject", "activity"))
