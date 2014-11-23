# README file of my "UCIHAR" repo

###What is `in` this repo:

This repo contains four (4) files:

1. **README.md**:  
This markdown file describing what is in this repo.
2. **CodeBook.md**:  
The code book for the course project of the Coursera course entitled "Getting and Cleaning data".
3. **run_analysis.R**:  
The R script for running all what was requested to be done for the course project.
4. **myTidyData.txt**:  
The resulting tidy data file.

###What is this repo `about`:

This repo has been created for a course project. The purpose of the course project was to demonstrate ability to collect, work with, and clean a data set. The goal was to prepare tidy data that can be used for later analysis. We were be graded by our peers on a series of yes/no questions related to this course project.  

For this course project, we were required to submit:  

1. a tidy data set as described below,
2. a link to a Github repository with our script for performing the analysis,
3. a code book describing the variables, the data, and any transformations or work that were performed to clean up the data called **CodeBook.md**. 

A **README.md** had also to be included in the repo with the three (3) above files. 

###What were `data` we had to work with `about`:

Data were coming from one of the most exciting areas in all of data science right now: wearable computing - see for example this article 
http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/. 

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.  

The data linked to the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.  

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here is a link to get the `original data` used for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

####Quick description of original datasets:  
  
Original datasets are organised with a main directory, under which there is two (2) sub-directories, each of them having its own subdirectory. Directory structure and files contained in are as follow:  
  
-`/UCI HAR Dataset`: main directory which includes four (4) files and two (2) subdirectories:  
-`/UCI HAR Dataset/README.txt`: general description of the experiment and files given in the zipped file;  
-`/UCI HAR Dataset/features_info.txt`: shows information about the variables used on the feature vector;  
-`/UCI HAR Dataset/activity_labels.txt`: links the class labels with their activity name (1 column, 6 observations);  
-`/UCI HAR Dataset/features.txt`: list of all features (2 columns, 561 observations);  
  
Authors of that study decided to randomly partitioned the dataset into two (2) sets (70% of the volunteers was selected for generating the **training** data, 30% the **test** data):  
  
-`/UCI HAR Dataset/test` : subdirectory including three (3) files and one (1) subdirectory:  
-`/UCI HAR Dataset/test/subject_test.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.  
-`/UCI HAR Dataset/test/X_test.txt`: Test set;  
-`/UCI HAR Dataset/test/y_test.txt`: Test labels;  
-`/UCI HAR Dataset/test/Inertial Signals`: not used for course project => not described.  

Exactly the same structure and files are retrieved under subdirectory `/UCI HAR Dataset/train`. Only substring **"test"** of the various file names has been changed to **"train"**.  

####What were the features (or information) recorded through the experiment:  

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals **tAcc-XYZ** and **tGyro-XYZ**.  
  
These time domain signals (prefix **'t'** to denote **time**) were captured at a constant rate of 50 Hz.  
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.  
  
Similarly, the acceleration signal was then separated into **body** and **gravity** acceleration signals (**tBodyAcc-XYZ** and **tGravityAcc-XYZ**) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
  
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain **Jerk** signals (**tBodyAccJerk-XYZ** and **tBodyGyroJerk-XYZ**).  
  
Also the **magnitude** of these three-dimensional signals were calculated using the Euclidean norm (**tBodyAccMag**, **tGravityAccMag**, **tBodyAccJerkMag**, **tBodyGyroMag**, **tBodyGyroJerkMag**). 
  
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing **fBodyAcc-XYZ**, **fBodyAccJerk-XYZ**, **fBodyGyro-XYZ**, **fBodyAccJerkMag**, **fBodyGyroMag**, **fBodyGyroJerkMag**. (Note the **'f'** to indicate **frequency** domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
**'-XYZ'** is used to denote 3-axial signals in the **X**, **Y** and **Z** directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value;  
- std(): Standard deviation;  
- mad(): Median absolute deviation;  
- max(): Largest value in array;  
- min(): Smallest value in array;  
- sma(): Signal magnitude area;  
- energy(): Energy measure = sum of the squares divided by the number of values;  
- iqr(): Interquartile range;  
- entropy(): Signal entropy;  
- arCoeff(): Autorregresion coefficients with Burg order equal to 4;  
- correlation(): correlation coefficient between two signals;  
- maxInds(): index of the frequency component with largest magnitude;  
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency;  
- skewness(): skewness of the frequency domain signal;  
- kurtosis(): kurtosis of the frequency domain signal;  
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window;  
- angle(): Angle between to vectors.  
  
Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:  

- gravityMean;  
- tBodyAccMean;  
- tBodyAccJerkMean;  
- tBodyGyroMean;  
- tBodyGyroJerkMean.
  
The complete list of variables of each feature vector is available in `features.txt`. Built by the original study authors following the rules just described above, there are **561** unique feature names.
  
  
###What were the objectives of the course project using the `original data` sets:  
  
1) **Create an R script called `run_analysis.R` doing the following**:  

1.1. Merging the **training** and the **test** sets to create one data set:  

This was done by:  
- downloading the **original zipped** file and **unzipping** it;  
- reading file `/UCI HAR Dataset/features.txt`to get the **561 feature names** given by authors;  
- reading file `/UCI HAR Dataset/activity_labels.txt`to get the **6 activity names** recorded;  
- applying a function `readDF()` which reads each **test** and **train** files, name their columns and merge them to create single **test** and single **train** datafile. Note that `readDF()` takes `subDataType`as argument which can take **train** or **test** as value, used to identify the right subdirectories and datafiles;   
- row binding **test** and **train** datafiles.  


This step ends with creation of a global datafile named **HAR1** for **STEP01** (**HAR** stands for **H**_uman_ **A**_ctivity_ **R**_ecognition_").  
**HAR1** = dataframe of **10299** observations and **563** variables (i.e. columns).  
  
  
1.2. Extracting only the measurements on the mean and standard deviation for each measurement:  
  
This was done by:  
- Using `grep()` function, to keep only columns with substrings **"mean()"** or **"std()"** in their string name;  
- Removing all the other columns except **"subject"** and **"activity"**);  
- Excluding **"meanFreq"** columns as they are not mean but weighted averages.  
  
  
This step ends with creation of a global datafile named **HAR2** for **STEP02**.  
**HAR2** = dataframe of **10299** observations and **68** variables (i.e. columns).  
  
  
1.3. Using descriptive activity names to name the activities in the data set:  

Original **"activity"** variable was **numeric**.  
It was transformed into a **factor** using descriptive activity names `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`coming from `activity_labels.txt`.  
  
  
This step ends with creation of a global datafile named **HAR3** for **STEP03**.  
**HAR3** = dataframe of **10299** observations and **68** variables (i.e. columns).  
  
  
1.4. Appropriately labeling the data set with descriptive variable names;  

Before this step, remaining column names were names issued from `features.txt` (the file containing **561 feature names** given by authors).  

However, there are several "errors" in the original naming convention, notably:
- metacharacters like `(` and `)`, and syntactically non valid character `-` (both can be identified using make.names() function);  
- naming errors like `BodyBody` in some column names which are more difficult to identify. Only way to find such errors is looking carefully all names;    

To fix these "errors":
- All remaining column names were extracted into a vector, and for each row of that vector:    
- `gsub()` was used as there was sometimes several occurences of `-` in a single name:  
  - to find character `-` and replace it with a dot `.`;  
- `sub()` function was used for single occurence in a single name:  
  - to find metacharacters `(` and `)` and replace them with an empty string `""`. Note also that the search-replace for `(` and `)` was done using `sub()` argument `pattern="\\(\\)"`.   
  - to find `BodyBody` occurences and replace them with `"Body"`;  
 

Then, `rename.vars()` from package `gdata`was used to rename old column names with new ones.  
This step ends with creation of a global datafile named **HAR4** for **STEP04**.  
**HAR4** = dataframe of **10299** observations and **68** variables (i.e. columns).  


1.5. From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject.

This was done by:
- ordering the **STEP04** file firstly by **"subject"** and secondly by **"activity"**;  
- using `aggregate()` function using its `FUN=mean`argument;  
- suppressing unecessary columns.

This step ends with creation of a global datafile named **HAR5** which is a dataframe of **180** observations and **68** variables (i.e. columns). 


##**HOWEVER** even if small, and nicely shaped, **HAR5** IS NOT a `tidy` dataset.

###What had to be done to get an `independant tidy dataset`:

Looking at the columns names in **HAR5** (which is presented in a small **narrow** format at this stage: 180 x 68), it can easily be seen that there is in fact **multiple variables in each column**.

Each column name :
- starts with `t`or `f` which stand for `time`and `frequency`and can be defined as `domainSignal` variable;  
- contains in second place, `Body` or `Gravity` which can be defined as `accelerationSignal` variable;  
- contains in third place, `Acc`or `Gyro` which stand for `accelerometer`and `gyroscope` and can be defined as `measurementSystem` variable;  
- may contains in fourth place, `Jerk` which can be defined as `jerkSignal` variable;  
- may contains in fifth place, `Mag` which can be defined as `magnitude` variable;  
- contains in sixth place, `mean` or `std` which can be defined as `estimator` variable;  
- may contains in seventh place, `X`, `Y` or `Z` which can be defined as `axis` variable.    

**HAR5** was then transformed into **independant tidy dataframe** named `tidy`:  
- using `reshape2` package function `melt()` resulting in a dataframe of **11880** observations and **4** columns named "subject", "acticty", "variable" and "value";  
- renaming column named "value" with "average";  
- arranging `tidy`by subject, activity, variable;  (not very important!)
- creating seven (7) variables based on the characteristics of the seven (7) column names described in the previous paragraph;  
- adding these seven (7) new variables to `tidy` dataframe;  
- arranging `tidy`dataframe by "activity", "variable", "subject";  
- reordering columns with column order:  
"subject", "activity", "domainSignal", "accelerationSignal", "measurementSystem", "jerkSignal", "magnitude", "estimator", "axis", "average".  

This step ends with creation of a global datafile named `tidy` which is a dataframe of **11880** observations and **10** variables (i.e. columns). 

`tidy`was also saved with `write.table()` command using `row.name=FALSE` as argument (project assignment request) in order to save it as a text file. The file saved was named `myTidyData.txt'.

`tidy`can easily be retrieved in [R] with `read.table()` function using `header=TRUE` as argument.


2) **Submit**:

- a tidy data set as described above (named: `myTidyData.txt`),  
- a link to a Github repository with our script for performing the analysis,  
- a code book describing the variables, the data, and any transformations or work that were performed to clean up the data called `CodeBook.md`,  
- a `README.md` file (this file).