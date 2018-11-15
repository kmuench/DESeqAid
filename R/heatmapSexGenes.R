#' Heatmap of Sex Marker Genes
#'
#' This function allows you to make a heatmap of sex marker gene expression for the samples in your study to make sure you categorized their sex correctly.
#' Pro tip: male samples are more likely to have high X marker expression and high Y marker expression because of maternal contamination.
#' @param myData_rlg An rlog-normalized DESeqDataset object produced using DESeq's DESeqDataSetFromHTSeqCount() and rlog() functions
#' @param hugoOrEnsembl Either a 1 (for HUGO annotations) or 2 (for Ensembl annotations)
#' @param sampleTable sampleTable used to import data into DESeq's DESeqDataSetFromHTSeqCount() function
#' @param myTitle The title that will display over the plot
#' @keywords DESeq2
#' @keywords Heatmap
#' @export
#' @examples
#' heatmapSexGenes(amySexGenes_Counts, sampleTable, 'Expression of Sex Genes in Samples')
#' 

heatmapSexGenes <- function(myData_rlg, hugoOrEnsembl, sampleTable, myTitle){

# Declare some Sex Genes Amy suggested as markers
amySexGenes <- data.frame( genes = c('XIST', 'DDX3Y','UTY','USP9Y','RPS4Y') ,
                           ensembl= c('ENSMUSG00000086503', 'ENSMUSG00000069045',
                                      'ENSMUSG00000068457', 'ENSMUSG00000069044',
                                      'ENSMUSG00000063171') )

# create plot data
plotData <- subset(assay(myData_rlg), subset = row.names(assay(myData_rlg)) %in% amySexGenes[,hugoOrEnsembl], row.names = amySexGenes[,hugoOrEnsembl])

#import libs
library(ggplot2)
library(reshape2)

# finish making plotdata
col.order <- sampleTable[order(sampleTable$Sex == 'F')]
plotData <- myData_rlg[,col.order]

# assign colors

sexOrder <- sampleTable[match(colnames(plotData), sampleTable$FileName), 'Sex']

sampleColors <- ifelse( sexOrder == 'F', '#FF33EC', '#335EFF')

# format plotting dataframe
plotData <- melt(plotData)

# plot
ggplot(plotData, aes(x=Var1, y=Var2 ))  +
  geom_tile(aes(fill = value), color = "white") +
  ggtitle(myTitle) +
  scale_fill_gradient(low = "white", high = "red") +
  ylab(paste0("Samples")) +
  theme(axis.text.y=element_text(colour = sampleColors)) +
  xlab("Sex-linked Genes") +
  labs(fill = "Expression level") +
  theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=13), axis.text.y = element_text(size=8)) +
  theme(legend.position = "none",
        axis.ticks = element_blank(), 
        axis.text.x = element_text(angle = 330, hjust = 0)) +
  scale_x_discrete("", expand = c(0, 0)) + 
  scale_y_discrete("", expand = c(0, 0)) 
}
