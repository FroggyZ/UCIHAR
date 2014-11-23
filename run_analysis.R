################################################################################
####                     GETTING AND CLEANING DATA                          ####
####                          COURSE PROJECT                                ####
####                      Program: run_analysis.R                           ####
################################################################################

#-------------------------------------------------------------------------------
#    STEP 00: Download and extract raw datafiles.
#-------------------------------------------------------------------------------

## set directory where to download "zipped" datafile and unzip it
## (will also be the working directory for the project)
setwd("C:/RWork/DataScience/03-GettingAndCleaningData/Project")
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url, 'Dataset.zip')
unzip('Dataset.zip')

## Define "raw" data directory
dataDirectory = "C:/RWork/DataScience/03-GettingAndCleaningData/Project/UCI HAR Dataset"

#-------------------------------------------------------------------------------
#    STEP 01: Merges the training and the test sets to create one data set.
#-------------------------------------------------------------------------------

## 1.1) Read "features" and "activity_labels" files

## "features.txt" contains names of 561 variables contained in "X_test" and 
## "X_train" files
features        <- read.table(paste(dataDirectory,"/features.txt", sep=""))
names(features) <- c("variableNumber","variableName")

## "activity_labels.txt" contains labels of the 6 activities recorded
activity_labels <- read.table(paste(dataDirectory,"/activity_labels.txt", sep=""))
names(activity_labels) <- c("activityNumber", "activityLabel")

## 1.2) Read each "test" and "train" files, name their variables and merge them
##      to create a single "test" and a single "train" dataset

readDF <- function(subDataType){
        
        for(i in c("subject","X","y")){
                
                DFName <- paste(i, "_", subDataType, sep="")
                DF <- read.table(paste(dataDirectory,"/",subDataType,"/", DFName, ".txt", sep=""))
                
                if(i=="subject"){
                        names(DF) <- "subject"
                }else if(i=="y"){
                        names(DF) <- "activity"
                }else names(DF) <- features$variableName
                
                assign(DFName, DF, envir = .GlobalEnv)
        }
        
        ## Merge "test" or "train" data files by column to get a global file
        ## with "subject" and "activity" assuming their internal order is OK
        if(subDataType=="test"){
                dataTest <<- cbind(subject_test,y_test,X_test)
        }else if(subDataType=="train") {
                dataTrain <<- cbind(subject_train, y_train, X_train)
        }
}

readDF("test")
readDF("train")

## Now merge "test" and "train" data with row binding to get the global datafile
## which will be named "HAR1" for "Human Activity Recognition" - STEP01.
HAR1 <- rbind(dataTest, dataTrain)

#-------------------------------------------------------------------------------
# STEP 02: Select only the measurements on the mean and standard deviation 
#          for each measurement. 
#-------------------------------------------------------------------------------

## Use "grep" function, to keep only variable names with substrings "mean()" or 
## "std()" in their string name (and remove all the others except "subject" and 
## "activity") - Exclude "meanFreq" columns as they are not mean but weighted 
## averages.

HAR2 <- HAR1[ , c("subject", "activity", grep("mean\\(\\)|std\\(\\)", 
                                              names(HAR1), value=TRUE))]

#---------------------------------------------------------------------------------
# STEP 03: Uses descriptive activity names to name the activities in the data set. 
#---------------------------------------------------------------------------------

## Create the file which will be the results of step03
HAR3 <- HAR2

## Transform numeric variable "activity" to a factor with descriptive activity
## names

HAR3$activity = factor(HAR3$activity)
levels(HAR3$activity) = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                          "SITTING","STANDING","LAYING")

#-------------------------------------------------------------------------------
# STEP 04: Appropriately labels the data set with descriptive variable names.
#-------------------------------------------------------------------------------

varNames <- colnames(HAR3)                                                    ## Extract column names
                                                                              ## Change for correct [R] names:
varNames <- gsub("-", ".", varNames)                                          ## gsub "-"        with "."    (>1 occ.)
varNames <- sub(pattern="\\(\\)", replacement="", varNames)                   ## sub  "()"       with ""     ( 1 occ.)
varNames <- sub("BodyBody","Body",varNames)                                   ## sub  "BodyBody" with "Body" ( 1 occ.)

library(gdata)                                                                ## Load "gdata" previously installed
HAR4 <- HAR3                                                                  ## Create Dataframe HAR4 (ending step 04)
HAR4 <- rename.vars(HAR4, names(HAR4), varNames)                              ## Rename old variable names with new ones


#*******************************************************************************
# STEP 05: From the data set in step 4, creates a second, independent tidy data
#          set with the average of each variable for each activity and each 
#          subject.
#*******************************************************************************

## Order that file firstly by "subject" and secondly by "activity"
HAR5 <- HAR4[order(HAR4$subject, HAR4$activity), ]

## Use aggregate() function for doing that and suppress unecessary columns
HAR5 <- aggregate(HAR5, by=list(subject=HAR5$subject, activity=HAR5$activity), 
                  FUN=mean)
HAR5 <- HAR5[ ,c(1:2, 5:70)]                                                  ## Suppress columns 3 & 4 (original
                                                                              ## "subject" & "activity" columns)

## However, even if small, and nicely sahped, HAR5 is NOT a tidy dataset.

## As there is multiple variables by columns, create tidy data to get 
## one variable by column using tidy tools from "reshape2", "stringr" and "plyr"
## packages

library(reshape2)
library(stringr)

tidy <- melt(HAR5, id=c("subject","activity"), ra.nm=TRUE)                    ## 1st melts HAR5 file
names(tidy)[4] <- "average"                                                   ## names output variable (from aggregate)
tidy <- arrange(tidy, subject, activity, variable)                            ## arrange observations

## 1 single column can have a maximum of 7 variable in it
## ==> we will extract and build these 7 variables in order
## to create the final tidy dataset.

var1 <- NULL                                                                  ## extract variable 1 information
for(i in 1:length(tidy$variable)) {                                           ## on "t" and "f"
        if(length(str_sub(tidy$variable[i],1,1) == 1)){                              
                var1 <- rbind(var1, "time")
        }else{
                var1 <- rbind(var1, "frequency")
        }
}                                           

var2 <- NULL                                                                  ## extract variable 2 information
for(i in 1:length(tidy$variable)) {                                           ## on "Body" and "Gravity"
        if(length(grep("Body", tidy$variable[i])) == 1){                              
                var2 <- rbind(var2, "body")
        }else{
                var2 <- rbind(var2, "gravity")
        }
}

var3 <- NULL                                                                  ## extract variable 3 information
for(i in 1:length(tidy$variable)) {                                           ## on "Acc" and "Gyro"
        if(length(grep("Acc", tidy$variable[i])) == 1){                              
                var3 <- rbind(var3, "accelerometer")
        }else{
                var3 <- rbind(var3, "gyroscope ")
        }
}

var4 <- NULL                                                                  ## extract variable 4 information
for(i in 1:length(tidy$variable)) {                                           ## on "Jerk" or not
        if(length(grep("Jerk", tidy$variable[i])) == 1){                              
                var4 <- rbind(var4, "Yes")
        }else{
                var4 <- rbind(var4, "No")
        }
}

var5 <- NULL                                                                  ## extract variable 5 information
for(i in 1:length(tidy$variable)) {                                           ## on "Mag" or not
        if(length(grep("Mag", tidy$variable[i])) == 1){                              
                var5 <- rbind(var5, "Yes")
        }else{
                var5 <- rbind(var5, "No")
        }
}

var6 <- NULL                                                                  ## extract variable 6 information
for(i in 1:length(tidy$variable)) {                                           ## on "mean" or "std"
        if(length(grep("mean", tidy$variable[i])) == 1){                              
                var6 <- rbind(var6, "mean")
        }else if(length(grep("std", tidy$variable[i])) == 1){
                var6 <- rbind(var6, "std")
        }
}

var7 <- NULL                                                                  ## extract variable 7 information
for(i in 1:length(tidy$variable)) {                                           ## on "X","Y","Z" or NA
        if(length(grep("X", tidy$variable[i])) == 1){                              
                var7 <- rbind(var7, "X")
        }else if(length(grep("Y", tidy$variable[i])) == 1){
                var7 <- rbind(var7, "Y")
        }else if(length(grep("Z", tidy$variable[i])) == 1){
                var7 <- rbind(var7, "Z")
        }else {
                var7 <- rbind(var7, NA)
        }
}

tidy$domainSignal       <- as.vector(var1)                                    ## add these new columns to tidy
tidy$accelerationSignal <- as.vector(var2)
tidy$measurementSystem  <- as.vector(var3)
tidy$jerkSignal         <- as.vector(var4)
tidy$magnitude          <- as.vector(var5)
tidy$estimator          <- as.vector(var6)
tidy$axis               <- as.vector(var7)

tidy <- arrange(tidy, activity, variable, subject)                            ## arrange the final tidy data set
tidy <- tidy[c("subject","activity","domainSignal","accelerationSignal",
               "measurementSystem","jerkSignal","magnitude","estimator",
               "axis","average")]                     ## reorder columns of the tidy data set
str(tidy)

## Write tidy data set
write.table(tidy, file="myTidyData.txt", row.names = FALSE)