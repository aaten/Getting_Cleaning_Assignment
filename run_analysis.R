#1.- Merges the training and the test sets to create one data set.
#a)get the headers from the featrues table
#-------------------------------------------------------------------------------
a<-read.table("features.txt",sep = " ")
header<-a[,2]
#b)Read data and merge into one dataset
#--------------------------------------------------------------------------------
train<-read.table("./train/X_train.txt",header = FALSE,col.names = header)
test<-read.table("./test/X_test.txt",header = FALSE,col.names = header)
subjectx<-read.table("./train/subject_train.txt",col.names = "Subject")
subjecty<-read.table("./test/subject_test.txt",col.names = "Subject")
acttrain<-read.table("./train/y_train.txt",col.names = "Activity")
acttest<-read.table("./test/y_test.txt",col.names = "Activity")
ftrain<-cbind(subjectx,acttrain,train)
ftest<-cbind(subjecty,acttest,test)
conjunto<-rbind(ftrain,ftest)
#-------------------------------------------------------------------------------
#2.- Extracts only the measurements on the mean and standard deviation for each measurement.
b<-grep("mean|std", header,ignore.case = TRUE,value=FALSE)
#a)2 must be added to filter as subject and activity columns have been included. and filter.
filter<-b+2
extracts<-conjunto[,c(1,2,filter)]
#-------------------------------------------------------------------------------
#3 - Uses descriptive activity names to name the activities in the data set
# 2 Steps a)create a funtion to substitute b)sapply to column
cambio<-function(x){
    if (x==1){
        x="Walking"
    }else if (x==2){
        x="Walking Upstairs"
    }else if (x==3){
        x="Walking Downstairs"
    }else if (x==4){
        x="Sitting"
    }else if (x==5){
        x="Standing"
    }else if (x==6){
        x="Laying"
    }
    
}
extracts$Activity<-sapply(extracts$Activity,cambio)
#--------------------------------------------------------------------------------
# 4- Appropriately labels the data set with descriptive variable names.
names(extracts)<-gsub("^t","Time ",names(extracts))
names(extracts)<-gsub("^f","Fast Fourier Transform ",names(extracts))
names(extracts)<-gsub("\\.\\.\\."," Axis ",names(extracts))
#--------------------------------------------------------------------------------
# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.
library(dplyr)
final<-tbl_df(extracts)
agrupados<-group_by(final,Subject,Activity) 
resultf<-summarise_each(agrupados,funs(mean))
View(resultf)
write.table(resultf,file = "TidyDataSet.txt",row.names = FALSE)
