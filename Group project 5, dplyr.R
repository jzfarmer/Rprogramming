# Group project data wrangling with Dplyr

RNAseqdata<-read.table("RNAseq-data.txt",
                       sep = "\t",
                       as.is = T,
                       header = T)
colnames(RNAseqdata)

# reorganize the data
reorganized<-RNAseqdata[,c(3,4:7,1,2,8,9,10:13)]

# import RNAseq annotated data
AnnotatedRNAseq<-read.delim("RNAseq-Annotation.txt")

# combine tables with dplyr, with ensembl ID and ensemble gene being the same
Combineddata<-left_join(reorganized,
                        AnnotatedRNAseq,
                        by = c("Ensembl_gene" = "Ensembl.IDs"))
# sort combined data by fold change high to low
Sorteddata<-arrange(Combineddata, desc(fold.change))

# use head and tail functions to find the top upregulated and downregulated genes
head(Sorteddata[,c(11,12,13,14)])
tail(Sorteddata[,c(11,12,13,14)])

# how many genes have a fold change of >2 and p val <.05
Upregulatedgenes<-filter(Sorteddata, fold.change > 2 & adjp <0.05)

# how many genes have fold change of <-2 and p val <.05
Downregulatedgenes<-filter(Sorteddata, fold.change < -2 & adjp <0.05)
