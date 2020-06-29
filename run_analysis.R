# R script for creating a tidy data set based on Samsung's data.

# Data downloading

library(dplyr)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "SamsungData.zip"

if (!file.exists(filename)){
        download.file(fileURL, filename, method="curl")
}

if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}


# 1. Merges the training and the test sets to create one data set.

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# 3. Uses descriptive activity names to name the activities in the data set

colnames(x_train) <- features[,2]
colnames(y_train) <- "activity"
colnames(subject_train) <- "subject"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activity"
colnames(subject_test) <- "subject"

colnames(activity_labels) <- c("activity", "activityType")

# Final merging of data into one data set called "merged_data"

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, y, x)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

tidy_data <- merged_data %>% select(subject, activity, contains("mean"), contains("std"))

# 4. Appropriately labels the data set with descriptive variable names.

tidy_data$activity <- activity_labels[tidy_data$activity, 2]

names(tidy_data) <- gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("tbody", "TimeBody", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frecuency", names(tidy_data))
names(tidy_data) <- gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <- gsub("gravity", "Gravity", names(tidy_data))
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

final_data <- tidy_data %>% group_by(subject, activity) %>% summarise_all(list(mean = mean))
write.table(final_data, "FinalData.txt", row.names = FALSE)

