# CodeBook
The purpose of this CodeBook is to describe the data sets created in the steps 4 & 5 of the Getting and Cleaning Data Course Project, which are:
  * tidy_data
  * tidy_mean_data

The original data used for the project can be downloaded at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original data is a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captures at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The 561 features selected for the database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ, prefix 't' to denote time. The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ). the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern: ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions).

  * tBodyAcc-XYZ
  * tGravityAcc-XYZ
  * tBodyAccJerk-XYZ
  * tBodyGyro-XYZ
  * tBodyGyroJerk-XYZ
  * tBodyAccMag
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
  * fBodyAcc-XYZ
  * fBodyAccJerk-XYZ
  * fBodyGyro-XYZ
  * fBodyAccMag
  * fBodyAccJerkMag
  * fBodyGyroMag
  * fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

  * mean(): Mean value
  * std(): Standard deviation
  * mad(): Median absolute deviation 
  * max(): Largest value in array
  * min(): Smallest value in array
  * sma(): Signal magnitude area
  * energy(): Energy measure. Sum of the squares divided by the number of values. 
  * iqr(): Interquartile range 
  * entropy(): Signal entropy
  * arCoeff(): Autorregresion coefficients with Burg order equal to 4
  * correlation(): correlation coefficient between two signals
  * maxInds(): index of the frequency component with largest magnitude
  * meanFreq(): Weighted average of the frequency components to obtain a mean frequency
  * skewness(): skewness of the frequency domain signal 
  * kurtosis(): kurtosis of the frequency domain signal 
  * bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
  * angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

  * gravityMean
  * tBodyAccMean
  * tBodyAccJerkMean
  * tBodyGyroMean
  * tBodyGyroJerkMean

A full description of the data and how it was collected is available at the site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



## tidy_data
Contains a subset of the original data after merging the training and the test data sets. The subset is obtained extracting only the measurements on the mean and standard deviation for each measurement. Later, descriptive activity names were used to name the activities in the data set, and finally the data set was appropriately labeled with descriptive variable names.

The operations made to create the data set were:

### Reading original data:
activity_labels<- read.table("activity_labels.txt")
names(activity_labels)<- c("activity_id", "activity")
features<- read.table("features.txt")
X_train<- read.table("train/X_train.txt")
y_train<- read.table("train/y_train.txt")
subject_train<- read.table("train/subject_train.txt")
X_test<- read.table("test/X_test.txt")
y_test<- read.table("test/y_test.txt")
subject_test<- read.table("test/subject_test.txt")

### Naming variables
names(X_train)<- features[, 2]
names(X_test)<- features[, 2]
names(y_train)<- "activity_id"
names(y_test)<- "activity_id"
names(subject_train)<- "subject_no"
names(subject_test)<- "subject_no"

### Combine the data
train_data<- cbind(X_train, y_train, subject_train, type= "training")
test_data<- cbind(X_test, y_test, subject_test, type= "test")
### Merging the training and the test sets to create one data set.
raw_data<- rbind(train_data, test_data)



## tidy_mean_data
Contains a independent tidy data set with the average of each variable for each activity and each subject, obtained from the tidy_data data set.
