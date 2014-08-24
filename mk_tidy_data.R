if(!file.exists("./data/UCI HAR Dataset")) {
    dir.create("./data/UCI HAR Dataset")
    tmpFile <- tempfile()
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile="./data/getdata_projectfiles_UCI HAR Dataset.zip",method="curl", tmpFile)
    unzip(tmpFile)
    unlink(tmpFile)
}
# Read the Variable (column) names
colNames <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)
# Read the "train" data measurements
data_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = colNames[,2])
# Read the Train data subjects corresponding to the measurements
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE,  col.names = c("Subject_ID"))
# Combine Train Measurement and Subjects datasets . Get only mean values and std deviation of the measurements - 
# columns that contain mean() or std() in the name.
data_train <- cbind(subject_train, data_train[,colNames[grep("(?:mean|std)\\(\\)", colNames[,2], perl=TRUE),1]])
# Read the Train Activity IDs corresponding to the measurements
activity_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE,  col.names = c("Activity_ID"))
# Combine Train Measurement and Activity ID datasets
data_train <- cbind(activity_train, data_train)

# Read the Test data measurements
data_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = colNames[,2])
# Read the Test data subjects corresponding to the measurements
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE,  col.names = c("Subject_ID"))
# Combine Test Measurement and Subject ID datasets. Get only mean values and std deviation of the measurements - 
# columns that contain mean() or std() in the name.
data_test <- cbind(subject_test, data_test[,colNames[grep("(?:mean|std)\\(\\)", colNames[,2], perl=TRUE),1]])
# Read the Test Activity IDs corresponding to the measurements
activity_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE,  col.names = c("Activity_ID"))
# Combine Test Measurement and Activity datasets
data_test <- cbind(activity_test, data_test)

# Merge Test and Train datasets
data_mrgd <-rbind(data_train, data_test)

# Read the Activity labels 
activity_lbls <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE,  col.names = c("Activity_ID", "Activity_Name"))
# Join Activity labels dataset and measurements
data_mrgd <- merge(activity_lbls, data_mrgd, by="Activity_ID")

# load reshape library
library(reshape2)
# Create unkeyed data.table containing the molten data
data_mrgd_mltd <- melt(data_mrgd, id=1:3)
# Recast and return ave/mean for each variable per activity per subject
data_tidy <- dcast( data_mrgd_mltd, Activity_Name + Subject_ID ~ variable , fun=mean)
# output Tidy data into a file
write.table(data_tidy, file="./UCI_HAR_tidy_data.txt", row.name=FALSE) 

