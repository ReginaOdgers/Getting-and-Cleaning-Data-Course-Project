---
title: "Code Book"
---

The `run_analysis.R`script contains the code required to meet the 5 intructions in the project's overview. I'll describe them in the same order as in the R script, which isn't necessarly the initial order provided in the instructions. 

### 1.  Merges the training and the test sets to create one data set

Once the folder called "UCI HAR Dataset" has been downloaded, the different data it contains is assigned to different variables as follows:

* `subject_train` <- `subject_train.txt`
Contains the train data of the subjects.
* `x_train` <- `x_train.txt`
Contains the recorded values for the train data.
* `y_train` <- `y_train.txt`
Contains the train data activities labels. 

* `subject_test` <- `subject_test.txt`
Contains the test data of the subjects.
* `x_test` <- `x_test.txt`
Contains the recorded values for the test data.
* `y_test` <- `y_test.txt`
Contains the test data activities labels. 

* `activity_labels` <- `activity_labels.txt`
Contains the names of the activities corresponding to the activity label.
* `features` <- `features.txt`
Contains the name of the features recorded for this data set.


### 3. Uses descriptive activity names to name the activities in the data set

With the following piece of code, column labels are assigned to each of the data frames in the different variables in order to make it more understandable. However, later on this initial column labels will be improved even more. 
```
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity"
colnames(subject_train) <- "subject"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activity"
colnames(subject_test) <- "subject"
colnames(activity_labels) <- c("activity", "activityType")
```

Once the columns have names and are easier to read and identify, we can proceed to merging the data into one final dataframe. 

`x` is created by merging `x_train` and `x_test` using the *rbind()* function.
`y` is created by merging `y_train` and `y_test` using the *rbind()* function.
`subject` is created by merging `subject_train` and `subject_test` using the *rbind()* function.

`merged_data` is created by merging `subject`, `y` and `x` using the *cbind()* function.This is the final merged data set. 

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

The `tidy_data` data set is created by subsetting `merged_data`, selecting only the columns: `subject` and `activity`, and the measurements: `mean` and `std`.

### 4. Appropriately labels the data set with descriptive variable names.

First, the label of the activity is assigned to the `tidy_data`so the name of the activity can be viewed instead of just the number. 

Also, the following abbreviations are substituted for a better understanding of the variable or column: 

* `Acc` is changed to `Accelerometer`
* `Gyro` is changed to `Gyroscope`
* `Mag` is changed to `Magnitude`
* `BodyBody` is changed to `Body`
* `tBody` is changed to `TimeBody`
* Columns beginning with `f` were changed to `Frequency`
* Columns beginning with `t` were changed to `Time`
* `mean()` is changed to `Mean`
* `std()` is changed to `STD`
* `freq()` is changed to `Frequency`

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This new tidy data is called `Final_data` and is obtained by grouping `tidy_data` by `subject` and `activity` and taking the `mean` of each variable. 
This is finally exported into a .txt file as `FinalData.txt`.


