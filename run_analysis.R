### Download and unzip the files
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./UCI_HAR_Dataset.zip")){
  download.file(url, destfile = "./UCI_HAR_Dataset.zip",mode = "wb",method = "curl")
  unzip(zipfile ="UCI_HAR_Dataset.zip",exdir=getwd())
}

### 1.read training and test data and merge these two together
### read data 
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

feature <- rbind(xtrain, xtest)
activity <- rbind(ytrain, ytest)
subject <- rbind(subjectTrain, subjectTest)

featurenames <- read.table("./UCI HAR Dataset/features.txt",head =FALSE)
### label variable names
names(activity) <- c("activity")
names(subject) <- c("subject")
names(feature) <- featurenames$V2

### merge into one dataset
datatemp <- cbind(subject,activity)
datafinal <- cbind(datatemp,feature)

### 2.Extracts only the measurements on the mean and standard deviation for each measurement.
subdata <- datafinal[,grepl("-mean\\(\\)|-std\\(\\)|subject|activity", colnames(datafinal))]

### 3. Uses descriptive activity names to name the activities in the data set
activity.label <- read.table("./UCI HAR Dataset/activity_labels.txt")
subdata[,2] <- activity.label[subdata[,2],2]

### 4. Appropriately labels the data set with descriptive variable names.
## label "subject"and "activity" variables in previous section. 
## here label "feature" variables with descriptive variable names
names(subdata) <- gsub("Acc", "Accelerometer", names(subdata))
names(subdata) <- gsub("Gyro", "Gyroscope", names(subdata))
names(subdata) <- gsub("Mag", "Magnitude", names(subdata))
names(subdata) <- gsub("^t", "Time", names(subdata))
names(subdata) <- gsub("^f", "Frequency", names(subdata))

### 5. From the data set in step 4, creates a second, independent tidy data set 
     ### with the average of each variable for each activity and each subject.
library(dplyr)
summary <- aggregate(x=subdata, 
                     by=list(activities = subdata$activity,subject1=subdata$subject),
                     FUN = mean)
summary <- summary[, !(colnames(summary) %in% c("subject1", "activity"))]
write.table(summary, './data_tidy.txt',row.names = FALSE)

