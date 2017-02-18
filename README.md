# Getting and Cleaning Data Course Project
Project repo for week 4 of Getting andCcleaning Data course.  Below is a description of the files in the repo.

##CodeBook.txt
A document describing the fields and observations in the dataset

##Script run_analysis.R
The script for performing the process of getting and cleaning data is called run_analysis.R.  This script: 

1. retrieves the source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, 
2. adds columns for the subject and activity performed for each observation.  
3. adds field labels to the data
4. selects only those columns that represent the mean or standard deviation (std) of their respective measurements
5. adds a human-readable label for the activity of each observation. Possible activities are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
6. produces a tidy dataset containing the mean of each observed variable for each activity-subject pair
7. saves the dataset as output.txt


##Tidy Dataset Output
The resulting dataset created by the run_analysis.R script is saved as output.txt.  It conforms to all of the criteria for Tidy data as outlined in Hadley Wickham's paper https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwidzrCm2ZrSAhVP3mMKHfO8BPAQFggcMAA&url=http%3A%2F%2Fvita.had.co.nz%2Fpapers%2Ftidy-data.pdf&usg=AFQjCNFUAQr-w_87XpPhfEDoDYQw5-G5zg&sig2=WvpA5iZDs-dDcpSXe3OrCQ:

1. each variable forms a column
2. each observation forms a row
3. each type of observational unit forms a table