x_train <- read.table("Dataset/train/X_train.txt")
x_test <- read.table("Dataset/test/X_test.txt")
# merging training and testing datasets
x <- rbind(x_train, x_test)
#lets name variables in x using features.txt
features <- read.table("Dataset/features.txt")
names(x) <- features$V2
# Searching rows with regular expression ".*-mean.*" or ".*-str.*" (meanFreq is
# mean too).
indices <- sort(c(grep(".*-mean.*",names(x)), grep(".*-std.*", names(x))))
x <- x[,indices]
# adding type of activity and subject id
activity_train <- read.table("Dataset/train/Y_train.txt")
activity_test <- read.table("Dataset/test/Y_test.txt")
subject_train <- read.table("Dataset/train/subject_train.txt")
subject_test <- read.table("Dataset/test/subject_test.txt")
subject_and_activity <- cbind(rbind(subject_train, subject_test), rbind(activity_train, activity_test))
names(subject_and_activity) <- c("subject", "activity")
x <- cbind(subject_and_activity, x)
# importing mapping between numbers 1 to 6 and activities
activity_labels <- read.table("Dataset/activity_labels.txt")
x$activity <- factor(x$activity, levels=activity_labels$V1, labels = activity_labels$V2)

#independent tidy data set
dataset <- x
dataset$activity <- as.numeric(dataset$activity)
dataset_matrix <- as.matrix(dataset)

matrix_cols = ncol(x)
tidy_matrix <- matrix(nrow = length(unique(dataset$subject))*length(unique(dataset$activity)), ncol = matrix_cols)
for (i in 1:max(dataset$subject)) {
      for (j in 1:max(dataset$activity)) {
            indices <- (dataset_matrix[ ,1] == i) & (dataset_matrix[ ,2] == j)
            tidy_matrix[j+(i-1)*max(dataset$activity), ] <- c(i, j, colMeans(dataset_matrix[indices, 3:matrix_cols]))
      }
}

tidy_dataset <- as.data.frame(tidy_matrix)
names(tidy_dataset) <- names(x)
tidy_dataset$activity <- factor(tidy_dataset$activity, levels=activity_labels$V1, labels = activity_labels$V2)
# I don`t know why we should put row.names = FALSE, but it is stated in the assignment
write.table(tidy_dataset, file="tidy_dataset.txt", row.names=FALSE)

