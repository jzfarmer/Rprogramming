# homework 5
# to cluster--create a distance matrix and cluster variables based on the distance matrix
dall<-dist(t(Orderedrmadata))
plot(hclust(dall))

# permutation based F test, in multtest package
help("mt.maxT")
# tell mt.maxT function what our groups are
mtlabel<-c(0,0,0,0,1,1,1,1,2,2,2,2,3,3,3)
# F-test with 20,000 permutations
Ftest<-mt.maxT(Orderedrmadata,
        classlabel = mtlabel,
        test = "f",
        B = 20000)
# how many probesets had 
nrow(Ftest[Ftest$rawp<=0.05,])

# order the Ftest by index
help("order")
OrderedFtest<-Ftest[order(Ftest$index),]

# create a new data frame that consists of the row names (affy IDs) and an average of the 8pm non-exercised groups
ControlNonEx8pm<-as.data.frame(rowMeans(Orderedrmadata[,1:4]))

# use colnames to change the column name of the new dataframe
colnames(ControlNonEx8pm)[1]<-"Ave_8pm_Controls"

# subtract the average value from the 8pm control group from each sample (including the 8pm controls). The goal is to create a matrix that has been transformed or normalized by the average value of the 8pm controls
Normalizedby8pm<-Orderedrmadata[,]-ControlNonEx8pm[,1]
