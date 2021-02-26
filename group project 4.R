library(affyQCReport) # to load in the library 
help("ReadAffy")
help("QCReport")

# to generate a QC report
library(affyQCReport)
affydata<-ReadAffy()
QCReport(affydata, output = "QCReport.pdf")

# to conduct RMA normalization of the data 
eset<-rma(affydata)
Rmadata<-exprs(eset)
help("rma")
help("exprs")

# reorder and run an ANOVA
Orderedrmadata<-Rmadata[,c(1,8:15,2:7)]
library(genefilter)
fac<-factor(c(0,0,0,0,1,1,1,1,2,2,2,2,3,3,3))
Anova<-rowFtests(Orderedrmadata,fac)
# use multtest package to help control false discovery rate
help("mt.rawp2adjp")
rawp<-Anova[,2]
Adjp<-mt.rawp2adjp(rawp, proc=c("Bonferroni", "Holm", "Hochberg", "SidakSS", "SidakSD",
                          "BH", "BY","ABH","TSBH"), alpha = 0.05, na.rm = FALSE)
str(Adjp)
adjustedpvalue<-as.data.frame(Adjp[c(1,2)])
write.table(adjustedpvalue, 
            file = "Logtabdelim", 
            sep = "\t",
            row.names = T,
            col.names = T)
