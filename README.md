### GettingAndCleaningData

Unzip the source ( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) into a folder on your local drive

Put run_analysis.R on the location where you stored the .zip file and in RStudio, setwd() and then source("run_analysis.R")

The R script runs and read the dataset and write these files "Tidy_Data_with_Labels.txt", "Tidy_Data_with_Averages.txt"

Use data <- read.table("data_set_with_the_averages.txt") to read. There are 30 subjects and 6 activities, thus "for each activity and each subject" means 30*6=180 rows. Note that the provided R script has no assumptions on numbers of records, only on locations of files.
