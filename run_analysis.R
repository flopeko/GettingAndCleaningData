# Load packages we are going to work with
library(dplyr)

# Set the wd
setwd("C:/_almacen/coursera/r programming/Getting and Cleaning Data Course Project")

# Read the data
activity_labels<- read.table("activity_labels.txt")
features<- read.table("features.txt")
X_train<- read.table("train/X_train.txt")
y_train<- read.table("train/y_train.txt")
subject_train<- read.table("train/subject_train.txt")
X_test<- read.table("test/X_test.txt")
y_test<- read.table("test/y_test.txt")
subject_test<- read.table("test/subject_test.txt")

# Naming variables
names(activity_labels)<- c("activity_id", "activity")
names(X_train)<- features[, 2]
names(X_test)<- features[, 2]
names(y_train)<- "activity_id"
names(y_test)<- "activity_id"
names(subject_train)<- "subject_no"
names(subject_test)<- "subject_no"

# Combining the x and y data and typing it as training or test data
train_data<- cbind(X_train, y_train, subject_train, type= "training")
test_data<- cbind(X_test, y_test, subject_test, type= "test")

#1. Merge the training and the test sets to create one data set.
raw_data<- rbind(train_data, test_data)

#set mean and standard deviation columns indexes
mean_std_col<- grep("mea[n][\\(]|std()", names(raw_data)) 
# the [\\(] regular expression is added to avoid MeanFreq() variables

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_data<- cbind(raw_data[, mean_std_col], raw_data[, 562:564])

#3. Uses descriptive activity names to name the activities in the data set
activity_names_data<- merge(x= mean_std_data, y= activity_labels, by= "activity_id")

# selecting colums to include in the tidy_data data set
col_order<- c(68, 70, 2:67)

# 4. creating the tidy_data data set
tidy_data<- activity_names_data[, col_order]

# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
tidy_mean_data<- group_by(tidy_data, subject_no, activity) %>% summarise_each(funs(mean))

# Generating a txt file with write.table to submit the data set in cousera.
write.table(x=tidy_mean_data, file="tidy_dataset.txt", row.names = FALSE)

# Removing the data not longer used
rm(X_train)
rm(y_train)
rm(subject_train)
rm(X_test)
rm(y_test)
rm(subject_test)
rm(train_data)
rm(test_data)
rm(mean_std_col)
rm(mean_std_data)
rm(activity_names_data)
rm(col_order)
rm(activity_labels)
rm(features)





