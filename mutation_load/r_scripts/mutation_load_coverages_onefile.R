library("ggplot2") #conda install -c r r-ggplot2
library(dplyr) #conda install -c r r-dplyr
library(scales)

rm(list=ls())
args <- commandArgs(trailingOnly=TRUE)
jpeg(args[2], width = 1024, height = 768)
df <- read.csv(args[1])
cumisum = sum(df$amount_of_number)
df1 <- mutate(df, freq=cumsum(percent))

ggplot(data=df1, aes(x=number_of_reads, y=freq), ylab="Fraction of Refseq bases covered") + geom_line(size=1.2, colour="red") + 
  scale_x_continuous("Read depth", trans='log10', expand = c(0, 0))+ 
  scale_y_continuous("Percent", labels = percent) + xlab("Number of reads") + ylab("Fraction of Refseq bases covered") + 
  ggtitle(paste("CDF function of reads covering genomic positions",df1$bam_file[1], sep=" ")) + annotation_logticks()

dev.off()