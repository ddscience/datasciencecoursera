# run_analysis.R

This script defines a series of functions:

* loadfile: loads whichever data file given the path (was planning to use it for special file read options)

* getfeatures: looks in the features.txt in the Samsung data and does two things
  it finds mean and standard deviations data and records the column numbers in its first column
  it also gets the names of the data for the above selected data and records this in the second column
  it returns the dataframe containing two columns with this "feature" information

*labelactivity: takes a dataframe and replaces the numerical activity in the "activity" column with the number and a descriptive   name of the activity
  it replaces all values in the supplied dataframe and returns it

*mergedata:  this is does a lot of the work in the script
  it takes as an argument a numerical vector of selected features or columns ( previously from getfeatures function)
  it loads all the y, x, subject data files for both the test and train data
  it filters the loaded data for those features/columns and puts it into 2 parellel dataframes: test/train
  it creates two new columns at the beginning of the dataframes: subject and activity and loads the appropriate data into those   columns
  it then combines or appends the test and train dataframes
  
  
##Main

At this point it is just a matter of calling the functions to clean up the data with one major operation at the end

It first gets the features and loads them into appropriate variables (standard deviation and means data)
Load and merge the bulk of the data into a dataframe
Take the dataframe and replace the numerical activity with a descriptive activity
Labels the data columns of the dataframe with more descriptive names from the features variable obtained eariler
Initialize a new dataframe which resembles the original dataframe (this will be the tidy dataframe with the condensed data)

The mean calculation is done by one aggregate function call by seperating out the two different factor column and averaging all the other data columns
It then reorders this new dataframe by the factors of subject and activity
