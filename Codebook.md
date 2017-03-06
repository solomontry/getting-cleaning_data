## Codebook for Getting and Cleaning Data Course Project
## Description of the project
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Steps 
Run_analysis.R performs downloading, cleaning and generating new tidy data sets.
1. Download and unzip the files UCI_HAR_Dataset.zip 

2. Read train and test data and merge these two together. First is to read the following txt files into R. 
`X_train.txt`
Three data `activity`,`subject`, `feature` are generated in the middle and merged into the final dataset `datafinal`. 

3. Extract only the measurements on the mean and standard deviation for each measurement. This step generates `subdata` dataset, which includes the subject, activity and mean and standard deviation for each measurement.

4. Label the activities and other variables 

5. Create a second, independent tidy data set `data_tidy.txt` with the average of each variable for each activity and each subject.










