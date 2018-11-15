#' Make a volcano plot
#'
#' This function allows you to make a volcano plot from your DESeq results.
#' It plots -log10 of your padjusted values against the log2 fold changes provided by DESeq.
#' Note that this is not equipped to plot shrunken Log2FCs, just the default DESeq ones - 
#' but if you label the shrunken log2FCs as "log2FoldChange", the function will plot those instead.
#' DE genes are colored red, and special other genes of interest colored in blue.
#' It draws lines at pvalue = 0.05, log2FC = 1.32 (~2.5fold change) and 0.585 (~1.5fold change)
#' 
#' @param volcanoPlotData a data frame (preferably of the DESeq results output file). Contains columns named log2FoldChange, padj; and has row names that are genes
#' @param genesToHighlight Genes that you'd like to color blue on this plot
#' @param highlightGeneName What do you want to call these other points you're coloring blue?
#' @param myTitle The title that will display over the plot
#' @param myX X axis label
#' @param myY Y axis label
#' @keywords DESeq2
#' @keywords RNA-Seq visualization
#' @export
#' @examples
#' makeVolcanoPlot(data.frame(results_sex_timepoint), amySexGenes[,2], 'Select Sex Genes', 'DE Genes based on interaction of Timepoint, Sex', 'Log2(Fold Change) relative to E12.5/M', '-log10(Adjusted p-value)')
#' 

makeVolcanoPlot <- function(volcanoPlotData, genesToHighlight, highlightGeneName, myTitle, myX, myY, currDate, nickname){
  
  # load needed libraries
  library(ggplot2)
  
  # declare needed variables
  lfc <- 1.32 # log2 fold change "interesting minimum". This means F is 2.5x bigger than M
  lfc_smaller <-0.585 #1.5- fold change threshold
  nl_pval <- -log10(0.05) # pvalue threshold
  
  # organize data for plotting. Not sure if pval should be padj
  vplotDat <- data.frame(logFC = as.numeric(volcanoPlotData$log2FoldChange), 
                         negLogPval = as.numeric(-log10(volcanoPlotData$padj) ),
                         Gene = row.names(volcanoPlotData),
                         Labels = factor('Other Gene', levels=c(highlightGeneName, 
                                                                'High Fold Change DE Gene', 
                                                                'Other Gene') ) ) # all genes
  
  
  # establish what genes are DE or should be specially colored
  vplotDat[vplotDat$Gene %in% vplotDat[abs(vplotDat$logFC) > lfc_smaller 
                                       & vplotDat$negLogPval > nl_pval,'Gene'],'Labels'] <- 'High Fold Change DE Gene'
  vplotDat[vplotDat$Gene %in% genesToHighlight,'Labels'] <- highlightGeneName
  
  # plot
  p <- ggplot(vplotDat, aes(logFC, negLogPval)) + 
    geom_point(aes(color = factor(Labels)), size = I(1.5), shape = 1) +
    geom_point(data = subset(vplotDat, Labels == highlightGeneName),
               size = I(2.5),
               aes(x = logFC, y = negLogPval, color = Labels)) +
    scale_color_manual(values=c('blue', 'red', 'black')) +
    geom_vline(xintercept = lfc_smaller, color='green') +
    geom_vline(xintercept = -lfc_smaller, color='green') +
    geom_vline(xintercept = lfc, color='green') +
    geom_vline(xintercept = -lfc, color='green') +
    geom_hline(yintercept = nl_pval, color='blue') +
    labs(title = myTitle, 
         x = myX, 
         y = myY)
  
  print(p)
  
  #This actually save the plot in a image
  ggsave(file=paste0(currDate,'_', nickname, '.svg'), p, width=10, height=8)
  
  
  # geom_text(mapping=aes(x= lfc_smaller, 
  #                       y=max(vplotDat$negLogPval) - 20, 
  #                       label='1.5fold' ), size=3, angle=90, vjust=-0.8, hjust=0) +
  # geom_text(mapping=aes(x= lfc, 
  #                       y=max(vplotDat$negLogPval) - 20, 
  #                       label='2.5fold' ), size=3, angle=90, vjust=-0.8, hjust=0) +
  # geom_text(mapping=aes(x= max(vplotDat$logFC) - 5, 
  #                       y=pval + 1, 
  #                       label='p=0.05' ), size=3, angle=0, vjust=-0.8, hjust=0) +
  
  
}