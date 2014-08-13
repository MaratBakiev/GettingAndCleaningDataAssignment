We started with the data that can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Downloadable archive also includes description of all variables.

Data was collected over 30 people and 6 types of activities for each of them.

First of all, we joined train and test data and named the columns of dataframe (we derived the names from the separate file).

Next, using regular expressions we took columns where mean or standard deviation data were stored.

After that, we joined this data with subjects' numbers and types of activity. We haven't used any type of key and just used the fact that all three tables was sorted properly (ith row of data belonged to the subject whose number was in the ith row).

In order to make activity variable a factor variable we imported mapping between activity numbers and their values.

After that we were ready to create tidy dataset.

We looped over unique values of subjects and activities, each time taking a submatrix of our data and applying colMeans function in order to calculate means of each variable.

So, our tidy dataset contains mean values of all variables that reflect mean or standard deviation values for each person by each type of activity. The meaning of all of the variables can be found by the link above.
