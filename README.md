# Getting-and-Cleaning-Data-Course-Project
Coursera Getting and Cleaning Data Peer-graded Assignment

This is the course project for the Getting and Cleaning Data Coursera course. 

The end result, i.e. the tidy data, are shown in the file tidy.txt.

The R script, run_analysis.R, does the following:
    1. Downloads and unzips dataset if it does not already exist
    2. Loads activity labels and features
    3. Loads the test and train data, but extracts only the measurements on the mean and standard deviation for each measurement
    4. Merges data sets and adds labels
    5. Turns activities and subjects into factors
    6. Creates tidy data set with the average of each variable for each activity and each subject
