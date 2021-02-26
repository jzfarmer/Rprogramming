# compute ttest and determine p values for the am data biopsies
help("rowttests")

# for rowttests, need to make a vector of labels, stored as
# a factor
label<-factor(c(0,0,0,0,1,1,1,1))

# compute ttests
ttests<-rowttests(as.matrix(PMexerciseandnonexercise),label)
help("as.matrix")

# merge data sets by row or column names
help("merge")
pmlogexercisedata.stats<-merge(ttests,PMexerciseandnonexercise, by = 0) # to merge by row names, row names is turned into a variable

#if row names is a separate column
library(tibble)
Rowttest2<-rownames_to_column(ttests)
PMlog

# make a histogram of the first column of data
help("hist")
hist(pmlogexercisedata.stats[,1])

# make a normal distribution to serve as our positive control
randomnormaldist<-rnorm(12625, mean = 7.868)
hist(randomnormaldist)

# make a bloxplot the normal distribution
boxplot(randomnormaldist)

# make histograms of raw and log transformed data for patient 3 exercise 8 pm
hist(Exercise$Patient.3.Exercise.8.pm)
hist(Logexercisedata$Patient.3.Exercise.8.pm)

# to see if our data is actually normal
# qqnorm graphs, qqline adds the line
help("qqnorm")
qqnorm(randomnormaldist)
qqline(randomnormaldist)
qqnorm(Exercise$Patient.3.Exercise.8.pm)
qqline(Exercise$Patient.3.Exercise.8.pm)
qqnorm(Logexercisedata$Patient.3.Exercise.8.pm)
qqline(Logexercisedata$Patient.3.Exercise.8.pm)
