# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Set your working directory where the data/folders are located.

#====================================================================
# 1. Merges the training and the test sets to create one data set.
#====================================================================

X_train <- read.table("train/X_train.txt")
X_test <- read.table("test/X_test.txt")
X_Dat <- rbind(X_train, X_test)

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
S_Dat <- rbind(subject_train, subject_test)

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
Y_Dat <- rbind(y_train, y_test)

#===========================================================================================
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#===========================================================================================

# Acquire headers for the data set
features <- read.table("features.txt")
MeanStd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X_Dat <- X_Dat[, MeanStd]
names(X_Dat) <- features[MeanStd, 2]
names(X_Dat) <- gsub("\\(|\\)", "", names(X_Dat))
names(X_Dat) <- tolower(names(X_Dat))  

#===========================================================================
# 3. Uses descriptive activity names to name the activities in the data set
#===========================================================================

act_labels <- read.table("activity_labels.txt")
act_labels[, 2] = gsub("_", "", tolower(as.character(act_labels[, 2])))
Y_Dat[,1] = act_labels[Y_Dat[,1], 2]
names(Y_Dat) <- "activity"

#======================================================================
# 4. Appropriately labels the data set with descriptive activity names.
#======================================================================

names(S_Dat) <- "subject"
cleaned <- cbind(S_Dat, Y_Dat, X_Dat)
write.table(cleaned, "Tidy_Data_with_Labels.txt")

#==================================================================================================================
# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
#==================================================================================================================
uniqueSubjects = unique(S_Dat)[,1]
numSubjects = length(unique(S_Dat)[,1])
numActivities = length(act_labels[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
    for (a in 1:numActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = act_labels[a, 2]
        tmp <- cleaned[cleaned$subject==s & cleaned$activity==act_labels[a, 2], ]
        result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row+1
    }
}
write.table(result, "Tidy_Data_with_Averages.txt",row.name=FALSE)