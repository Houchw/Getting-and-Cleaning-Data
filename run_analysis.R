
#read all the data set
train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")
activity_train <- read.table("train/y_train.txt")
features <- read.table("features.txt")
test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")
activity_test <- read.table("test/y_test.txt")

#re-prepare all the data set
colnames(train) <- features$V2
colnames(test) <- features$V2
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"
colnames(activity_train) <- "activity"
colnames(activity_test) <- "activity"

#merge all the data set
tmp1 <- cbind(subject_train, activity_train, train)
tmp2 <- cbind(subject_test, activity_test, test)
mydata <- rbind(tmp1, tmp2)

#subset the data set
m <- grep("mean", colnames(mydata))
s <- grep("std", colnames(mydata))
o <- c(1, 2, m, s)
o <- o[order(o)]
subdata <- mydata[, o]

#group the subdata
f <- read.table("activity_labels.txt", stringsAsFactors = F)
subdata$activity <- as.factor(subdata$activity)
levels(subdata$activity) <- f$V2
group <- split(subdata, subdata$subject)

#form the new data set
subject_id <- 1:length(group)
feature_id <- colnames(subdata)
feature_id <- feature_id[c(-1, -2)]
newdata <- data.frame()

for (subject in subject_id) {
  tmp <- tapply(group[[subject]][, 3], group[[subject]]$activity, mean)
  coltmp <- as.data.frame(tmp)
  activity_tmp <- data.frame(activity = rownames(tmp))
  for (j in feature_id) {
    tmp <- tapply(group[[subject]][, j], group[[subject]]$activity, mean)
    tmp <- as.data.frame(tmp)
    colnames(tmp) <- j
    coltmp <- cbind(coltmp, tmp)
  }
  coltmp <- cbind(subject, activity_tmp, coltmp)
  newdata <- rbind(newdata, coltmp)
}
newdata <- newdata[, -3] #delete the extra column

write.table(newdata, "newdata.txt", row.names = F)
