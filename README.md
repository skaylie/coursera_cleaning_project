## Getting and Cleaning Data Course Project
Project repo for week 4 of Getting andCcleaning Data course

#Script
The script for performing the process of getting and cleaning data is called run_analysis.R.  This script: 

1. retrieves the source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, combines the 
2. adds columns for the subject and activity performed for each observation.  Possible activities are: WALKING,
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
3. adds field labels to the data
4. selects only those columns that represent the mean or standard deviation (std) of their respective measurements
5. replaces the index number of respective