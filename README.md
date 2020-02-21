# GettingAndCleaningData
###Course Project: Getting and Cleaning Data

Script `run_analyses.R`:

#### Inputs:
* UCI HAR Dataset\\activity_labels.txt
* UCI HAR Dataset\\features.txt
* UCI HAR Dataset\\test\\subject_test.txt
* UCI HAR Dataset\\test\\X_test.txt
* UCI HAR Dataset\\test\\y_test.txt
* UCI HAR Dataset\\train\\subject_test.txt
* UCI HAR Dataset\\train\\X_test.txt
* UCI HAR Dataset\\train\\y_test.txt

#### Outputs:
* avg_activity_subject.txt

---

The script takes the raw data provided by the
[link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
unzipped to the working directory and merges the test and train data into one dataset (*combined_data*).

The output file *avg_activity_subject.txt* contains
the average mean and std-dev values of the test and train data grouped by
**subject_id** and **activity** also stored in the dataset *avg_activity_subject*