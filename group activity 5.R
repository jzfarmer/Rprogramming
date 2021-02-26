# Group activity 5

# use cbind to combine columns for the ordered F test with the normalized ratio data
help("cbind")

Combineddata<-cbind(Normalizedby8pm,
                    OrderedFtest,
                    deparse.level = 1)
# cluster ratios that have F test p < 0.05
diffrmaexratios<-Combineddata[Combineddata$rawp<=0.05,1:15]

# HOPACH clustering
help("distancematrix") #computes a matrix of all pairwise distances between your genes-use the cosangle parameter for genes!!
distgene<-distancematrix(diffrmaexratios, d = "cosangle")
hogene<-hopach(diffrmaexratios, dmat = distgene) #conducts hopach clustering using distance matrix and original data This will take a little while to run.
#produces a .cdt, and .gtr hopach cluster files that can be read with mapletree software.
hopach2tree(diffrmaexratios,
            file = "tree.gene",
            hopach.genes = hogene,
            dist.genes = distgene,
            d.genes = "cosangle")
#ALS411 Code to create a heatmap directly in R
#without having to use mapletree
#not this is not a hopach cluster

# Install and load necessary package(s) for making a heatmap

# install.packages("gplots")  # do this only once then comment out
library(gplots)

# Set up heatmap colors and breaks
breaks=seq(-1.2, #start point of color key, tweak these values to increase contrast
           1.2,  #end point of color key, tweak these values to increase contrast
           by=0.1) #length of sub-division
mycol=colorpanel(n=length(breaks)-1,low="green",mid="black",high="red") #heatmap colors

# Generate heatmap
heatmap.2(as.matrix(diffrmaexratios), #the expression matrix
          Colv=FALSE, #TRUE for column clustering
          Rowv=TRUE, #TRUE for row clustering
          distfun = function(x) dist(x,method = 'euclidean'), #"euclidean", "maximum", "manhattan", "canberra", "binary" or "minkowski"
          hclustfun = function(x) hclust(x,method = 'complete'), #"ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median" or "centroid"
          dendrogram = "row", #prevents an error message indicating only rows dendrogram made
          col=mycol, #colors used in heatmap
          breaks=breaks, #color key details
          trace="none", #no trace on map
          na.rm=TRUE, #ignore missing values
          margins = c(15,10), #size and layout of heatmap window
          xlab = "Exercise Samples", #x axis title
          ylab =  "Probesets", #y axis title
          main = "Exercise genes" ) #main title


# kmeans clustering for image analysis 
dat = read.table("sat.dat.txt")
str(dat)
summary(dat)

# assign names to columns
names(dat) = c("red","green","blue")
attach(dat)
help("attach")

# make a vector of colors, one color for each point
mycol = rgb(red,green,blue,max=255)

#specify the size of the image
rows=1:75
columns=1:40
z=matrix(1:3000,nrow=75)

#make the image
image(rows,columns,z,col=mycol)

# make 3D scatterplot
library(scatterplot3d) 
scatterplot3d(red,green,blue,color=mycol)

cl=kmeans(dat,2)
names(cl)
str(cl)
cl$cluster
cl$center
c2=rgb(cl$cen[,1],cl$cen[,2],cl$cen[,3],max=255)
c2

# Next we have to wrap the long vector cl$clus in to a 75 by 40 matrix in order to make the image.
image(rows,columns,matrix(cl$clus,75,40),col=c2)

# What about adding some more details? For this we shall increase k to 3, say.
cl2=kmeans(dat,3)
c3=rgb(cl2$cen[,1],cl2$cen[,2],cl2$cen[,3],max=255)
image(rows,columns,matrix(cl2$clus,75,40),col=c3)
