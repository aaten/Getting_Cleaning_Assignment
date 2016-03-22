#first I am going to read the features.txt to extract the column headers for the two data tables( test and train)
prueba<-read.table("features.txt", sep = " ")
# There need to be 561 labels corresponding each to the header of each column in the datatable. I verify this with
nrow(prueba)
# I create a variable to contain the column headers prior to importing the data tables
cabecera<-prueba[,2]
# I import the tables containing the data sets(train and test) and assign header created above
train<-read.table("./train/X_train.txt",header = FALSE,col.names = cabecera)
test<-read.table("./test/X_test.txt",header = FALSE,col.names = cabecera)
# Since the problem specifically asks only data that concern mean and standard deviation, I will filter the two tables
#so that only the columns with mean and std appear. To do this I will find the positions in the headers that contain
# the word mean() and std() and subset the orginal data set with the vector containing means and standard deviations
filtro<-grepl("mean|std", cabecera,ignore.case = TRUE)
# I check number of columns that relate to mean or std to verify, that when I do subsetting I will get correct number
# of columns
table(filtro)
# I subset the test and train datasets only for columns with mean and std deviation
train1<-train[,filtro]
test1<-test[,filtro]
# I verify that the resulting subsets have the correct number of columns
ncol(train1)
ncol(test1)
# I now create two variables for number of rows in each data set, to verify that when they are merged the total number
#is correct
registrain<-nrow(train1)
registest<-nrow(test1)
#In order to merge the columns we need to to bind them respecting the variable that identifies the subject from the
#training set from the test set. The variable will be the identifier of the person
#who undertook the study. I import the data of the subject as well as activity that was recorded (walking, sitting etc)
#in tables and bind them to the test and train subsets that have been subfiltered.
subtrain<-read.table("./train/subject_train.txt",col.names = "Subject")
subtest<-read.table("./test/subject_test.txt",col.names = "Subject")
#i verify that the total number of subjects must be 30, the addition of test + train
nbtrain<-nrow(unique(subtrain))
nbtest<-nrow(unique(subtest))
#I import the condition of (sitting, walking etc) of how each test was carried out.
acttrain<-read.table("./train/y_train.txt",col.names = "Activity")
acttest<-read.table("./test/y_test.txt",col.names = "Activity")
# I column bind the dataset of subjects, activity andmeasurements filtered (only mean and std) for the train and test
ftrain<-cbind(subtrain,acttrain,train1)
ftest<-cbind(subtest,acttest,test1)
conjunto<-rbind(ftrain,ftest)
#check if combined data set "conjunto" is of equal length as the two separate data sets "train" + test
total<-nrow(ftest)+nrow(ftrain)
nrow(conjunto)
# in order to rename activity to a more comprehensible description than numbers
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
conjunto$Activity<-sapply(conjunto$Activity,cambio)
#to group by activity and subject we load dplyr library and create pass create a table passing data.
final<-tbl_df(conjunto)
#next we group the table by activity and subject, summarizing the meanfor the 3 of the 86  variables (this can be 
#done for any of the 86 variables selected)
#agrupados<-group_by(final,Subject,Activity) Not usesd this next 4 lines
#resultado<-summarise(agrupados,TBodyAccMean=mean(tBodyAcc.mean...X),tGravityAcc.mean...X=mean(tGravityAcc.mean...X),
#                     fBodyGyro.mean...X=mean(fBodyGyro.mean...X),fBodyAccJerk.mean...Z=mean(fBodyAccJerk.mean...Z))
#View(resultado)
resultado<-ddply(conjunto, c("Subject","Activity"), numcolwise(mean))
View(resultado)
