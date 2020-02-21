library(dplyr)


####################################################
# Read data sets
####################################################

# read activity-labels and features
activity_labels<-read.table("UCI HAR Dataset\\activity_labels.txt", col.names = c("activity_id","activity"))
features<-read.table("UCI HAR Dataset\\features.txt")

# read test datasets
subject_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt", col.names = "subject")
x_test<-read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test<-read.table("UCI HAR Dataset\\test\\y_test.txt")

# Read train datasets
subject_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt", col.names = "subject")
x_train<-read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train<-read.table("UCI HAR Dataset\\train\\y_train.txt")

####################################################
# combine test and train datasets
####################################################
subjects<-rbind(subject_test, subject_train)
activity_id<-rbind(y_test, y_train)
combined_data<-rbind(x_test, x_train)

####################################################
# name columns and reduce columns to mean and stdev
####################################################

# name columns
names(combined_data)<-features[[2]]

# reduce columns to mean and standard deviation 
cols_mean_std<-features[grep("mean\\(|std\\(",features$V2),"V1"]
combined_data<-combined_data[,cols_mean_std]

# get rid of the () and - in the column-names
names(combined_data)<-gsub("\\(\\)","",names(combined_data))
names(combined_data)<-gsub("-","_",names(combined_data))


####################################################
# add activity and subject columns
####################################################

# add activity_id to combined data frame
combined_data$activity_id<-activity_id[[1]]

# function for translating activity_id to activity
get_activity<-function(id){
  as.character(activity_labels[(activity_labels$activity_id==id),"activity"])
}

# add translated activity column
combined_data$activity<-sapply(combined_data$activity_id,get_activity)

# add subjects to combined data frame
combined_data$subject_id<-subjects[[1]]

# reorder columns, move subject_id and activity to the front
combined_data<-select(combined_data,subject_id,activity,everything())

# remove activity_id column
combined_data<-select(combined_data,-(activity_id))

####################################################
# create new dataset with average of each variable 
# for each activity and subject_id
####################################################
avg_activity_subject<-combined_data %>% group_by(subject_id,activity) %>% summarise_all(mean)

# write output to file
write.table(avg_activity_subject,"avg_activity_subject.txt",row.name=FALSE)


