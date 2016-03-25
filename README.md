# Getting_Cleaning_Assignment
In this file repository you will find 3 files:
1) The tidy data set labelled "AssignmentL3.txt"
2) The codebook (file run_analysis.R) of how I finally obtained the data.
3) The present readme file

### Codebook

In order for you to quickly evaluate if the code is 
correct, I suggest to copy paste the code (if possible in RStudio)
To correctly read the text files, I have maintained the structure of
the directories from the dataset downloaded from Coursera. This is
a root directory and two subdirectories named "train" and "test". If
you have everything in one directory please delete the reference to 
the subdirectories ./train and ./test, and the code should run correctly.

In order for you to follow smoothly the sequence of events, I have structured
the code book following the sequence of requests made in the assignment:
1.- Merges the training and the test sets to create one data set.
2.- Extracts only the measurements on the mean and standard deviation for each measurement.
3 - Uses descriptive activity names to name the activities in the data set
4- Appropriately labels the data set with descriptive variable names
5 - From the data set in step 4, creates a second, independent tidy data set with the average of 
each variable for each activity and each subject.

If the everything goes ok at the end of the script if you are running RStudio you will get a pop-up
window with the resulting test requested.
