# This is a comment line, to help you remember how to run functions
# The first function I learned in R is the read.table function
# Before we run, lets pull up the help

help("read.table")

# when running help function, need to put the function in quotes

Exercise <- read.table("GSE1832_series_matrix-clean.txt",
                       as.is = T,
                       header = T,
                       sep = "\t",
                       row.names = 1)

# This gives the information about data type
str(Exercise)

# Get information about max, min, avg, quartiles
summary(Exercise)

# plot out the first variable as a dot plot
plot(Exercise[,1])

# another way to plot, use the dollar sign to grab a specific column
plot(Exercise$Patient.3.Nonexercise.8.pm)
