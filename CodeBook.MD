CodeBook.MD

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Relate all these to attributes.

Read files:
- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.


Read and combined these information:
- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt

- 'test/subject_test.txt

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

Extract only the measurements on the mean and standard deviation for each measurement:

Create a logical vector. 
Set 'TRUE' value for the ID, mean and stdev columns 
Set 'FALSE' values for the others. 

Subset this data to keep only the necessary columns.

Use descriptive activity names to name the activities in the data set:

Merge data subset with the activityType table to include the descriptive activity names

Appropriately label the data set with descriptive activity names:

gsub function: pattern replacement, clean up the data labels.

Create a second, independent tidy data set with the average of each variable for each activity and each subject:

Export a tidydata set with required condition.

