# tells you what packages are installed on your computer
library()

help("read.table")
help("read.delim")

Exercise <- read.table("GSE1832_series_matrix-clean.txt",
                       as.is = T,
                       header = T,
                       sep = "\t",
                       row.names = 1)

# to find out how many rows and columns are in our data frame
dim(Exercise)

# to find the column names in our data frame
colnames(Exercise)

# to find the highest mean value
summary(Exercise)

help("log")
# to transform the data to log2 into a new data frame
Logexercisedata <- log2(Exercise)

# making a new data frame with only the PM nonexercise and exercised data
PMexerciseandnonexercise <- Logexercisedata[,1:8]

help("plot")
# plotting control non-exercised log2 samples from patient 1 and 4 in the 8pm biopsies
plot(PMexerciseandnonexercise[,1],PMexerciseandnonexercise[,4])
plot(PMexerciseandnonexercise$Patient.1.Nonexercise.8.pm,PMexerciseandnonexercise$Patient.4.Nonexercise.8.pm)

# re-plotting, changing the axis names
plot(PMexerciseandnonexercise[,1],
     PMexerciseandnonexercise[,4],
     xlab = "Patient1",
     ylab = "Patient4")

help("write.table")
# using write.table to create a tab delimited text file into our working directory
write.table(Logexercisedata, 
            file = "Logtabdelim", 
            sep = "\t",
            row.names = T,
            col.names = T)


