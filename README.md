# Getting-and-Cleaning-Data
The assignment of the course 'Getting and Cleaning Data' on coursera

##Read all the data needed
"X_train.txt" "subject_train.txt" "y_train.txt" "features.txt"

"X_test.txt"  "subject_test.txt"  "y_test.txt"

##Re-prepare all the data set
Set the colnames of the data set

##Merge all the data set
Merge the 'subject_train', 'activity_train', 'train' into 'tmp1'

Merge the 'subject_test', 'activity_test', 'test' into 'tmp2'

Merge the 'train' and 'test' set together in rows to mydata labeld with 'subject' and 'activity'

##Extracts only the measurements on the mean and standard deviation for each measurement
Use the grep() to get the subs of the columns needed and saved the results in 'subdata'

##Group the the subdata
Group the subdata by 'activity' and 'subject'

##From the second new data set
Use for loop and tapply to get the average of each variable for each activity and each subject.

