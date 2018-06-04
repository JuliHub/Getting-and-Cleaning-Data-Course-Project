library(reshape2)

## Download Zip file and unzip the dataset:

filename <- "getdata_dataset.zip"
if (!file.exists(filename)){
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(URL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featureswanted <- grep(".*mean.*|.*std.*", features[,2])
featureswanted.names <- features[featureswanted,2]
featureswanted.names = gsub('-mean', 'Mean', featureswanted.names)
featureswanted.names = gsub('-std', 'Std', featureswanted.names)
featureswanted.names <- gsub('[-()]', '', featureswanted.names)


# Load the datasets of train data and combine
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featureswanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Load the datasets of test data and combine
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featureswanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featureswanted.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)