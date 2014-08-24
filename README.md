gcd-project1
============

### Assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 You should create one R script called run_analysis.R that does the following. 
 
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Content

    mk_tidy_data.R - R script - Read UCI HAR data and outputs UCI_HAR_tidy_data.txt tidy data file
    Code_Book.md - Data Dictionary for UCI_HAR_tidy_data.txt
    README.md - This README file
    UCI_HAR_tidy_data.txt - Tidy data file created by mk_tidy_data.R from UCI HAR Dataset
    
### Solution

    1.When mk_tidy_data.R R script is executed it checks if "UCI HAR Dataset" directory exists in ./data directory. If it does not exist it downloads the dataset drom the source and unzips it in the ./data directory. This will create the UCI HAR Dataset.
    2. Read Variable (column) names from "./UCI HAR Dataset/features.txt"
    3. For both train and test data import the data from the corresponfing directory ./UCI HAR Dataset/train/ and ./UCI HAR Dataset/test/:
        a. Read the data measurements from corresponting X_train.txt file
        b. Read the subject IDs from subject_train.txt files and merge them with subset of measurement data containing only mean values and std deviation of the measurements - Use regex to get only columns containing mean() or std() in the name.
        c. Read the Activity IDs from y_test.txt files and merge them with the measurement data
    4. Combine train and test data measurements into common data.frame
    5. Read the Activity labels from ./UCI HAR Dataset/activity_labels.txt" and join them with the measurements
    6. load reshape2 library - required for molten() and dcast()
    7. Create unkeyed data.table containing the molten data
    8. Recast and return ave/mean for each variable per activity per subject
    9. Output Tidy data into ./UCI_HAR_tidy_data.txt file
