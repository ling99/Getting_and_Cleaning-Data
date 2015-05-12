rm(list=ls())

setwd('/GCData/UCI HAR Dataset');
# Read files
features     = read.table('./features.txt',header=FALSE); 
activityType = read.table('./activity_labels.txt',header=FALSE); 

# Read files from train folder
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
xTrain       = read.table('./train/x_train.txt',header=FALSE); 
yTrain       = read.table('./train/y_train.txt',header=FALSE)

# Assign Column Name
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

# Merging Training Data Information
trainingDataInformation = cbind(yTrain,subjectTrain,xTrain);

# Read files from test folder
subjectTest = read.table('./test/subject_test.txt',header=FALSE); 
xTest       = read.table('./test/x_test.txt',header=FALSE); 
yTest       = read.table('./test/y_test.txt',header=FALSE);   

# Assign Column Name
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";

# Merging Test Data Information
testDataInformation = cbind(yTest,subjectTest,xTest);
  

# Step One: Merges the training and the test sets to create one data set.
  
MergedData = rbind(trainingDataInformation,testDataInformation);  

# Step Two: Extracts only the measurements on the mean and standard deviation on each measurement. 

colNames  = colnames(MergedData); 

logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

MergedData = MergedData[logicalVector==TRUE];

# Step Three: Uses descriptive activity names to name the data set activity
MergedData = merge(MergedData,activityType,by='activityId',all.x=TRUE);

# Step Four: Appropriately labels the data set with descriptive variable names. 
  
colNames  = colnames(MergedData);

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(MergedData) = colNames;

# creates a second, independent tidy data set with the average of each variable on each activity and each subject.
  
finalDataNoActivityType  = MergedData[,names(MergedData) != 'activityType'];

# Average of each variable on each activity and each subject

tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);

tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);

write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');