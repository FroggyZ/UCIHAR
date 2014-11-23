# Code book for `myTidyData.txt` created in the context of the course project "Getting and Cleaning data"

####What is `myTidyData.txt` about:

`myTidyData.txt` is a tidy dataset that has been created with original **Human Activity Recognition (HAR) Using Smartphones** datasets posted on the University of California, Irvine (UCI) web repo: [https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

All the  original datasets used to build `myTidyData.txt` are available for download at: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

An **in-depth description** of what has been done with the **original zipped datafile** is given in the `README.md` file.
 
####Quick reminder regarding the _design of the original experiment_:
_Sample size_: **30**  
_Selection criteria_: **Volunteers** within an age bracket of **19-48 years**  
_Information captured_: for details see README.txt and features_info.txt files included in the **zipped** datafile.  
_Experiment description_: 
- each subject performs six (6) activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING), wearing on his waist a smartphone (Samsung Galaxy S II) with embedded accelerometer and gyroscope;
- accelerometer and gyroscope record each 3-axial raw signals for linear acceleration and angular velocity. 

####UCI HAR tydi data dictionnary:  

`myTidyData.txt` is an independant tidy dataset of **11880** observations and **10** variables (i.e. column names).
It is a text file were all values are **delimiter-separated** (delimiter is " ") and is presented in a **very long narrow** format (**11880** rows x **10** columns).


|Column name        |Description                                 |Column type       |Length| Possible values      |
|-------------------|:------------------------------------------:|-----------------:|-----:| --------------------:|
|subject            |subject identification number               |integer           |2     | 1 to 30              |
|activity           |activity name                               |factor w/ 6 levels|18    | "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"|
|domainSignal       |domain of captured signal|character|9|"time", "frequency"|
|accelerationSignal |signal based on Butterworth filter|character|7|"body", "gravity"|
|measurementSystem  |smartphone embeded measurement tool|character|13|"accelerometer", "gyroscope"|
|jerkSignal         |body linear acceleration and angular velocity derived in time|character|3|"Yes","No"|
|magnitude          |calculated using the Euclidean norm|character|3|"Yes","No"|
|estimator          |indicator that was estimated from signal|character|4|"mean", "std"|
|axis               |X, Y or Z axis when meaningfull|character|1|"X", "Y", "Z", NA|
|average            |average of each variable for each activity and each subject|numeric|19|as much as observations|