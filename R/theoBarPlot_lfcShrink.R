#' The Theo Palmer Bar Plot ~for shrunken lfcs~
#'
#' Like theoBarPlot, but for shrunken LFCs.
#' 
#' Doesn't plot lfc standard error (yet).
#' 
#' Not only does this plot all of your differentially expressed genes as a bar plot with the Y axis representing 
#' SHRUNKEN log2fold change, but it also orders all of the bar from positive to negative, highlights the bar corresponding to
#' a list of interest, and draws a line at a threshold of your choosing.
#' 
#' @param myResults Results output from DESeq (can be a data frame too I suppose, e.g. output of add_lfcShrink)
#' @param highlightGenes column of data frame with genes you want to highlight
#' @param highlightGeneNames Character string representing what you want highlighted genes to be called in legend
#' @param fcThreshold Where do you want to draw horizontal line on plot? 
#' @param myTitle Character string representing title of plot
#' @param myTitle integer representing width of plot
#' @param myTitle integer representing height of plot
#' @keywords Results Visualization
#' @keywords DESeq
#' @export
#' @examples
#' theoBarPlot(results_sex, amySexGenes[,1], 0.58, 'Log2-Fold Change of Genes that are DE by Sex')


theoBarPlot_lfcShrink <- function(myResults, highlightGenes, highlightGeneName, fcThreshold, myTitle, myWidth, myHeight){
  
  # import needed libraries
  library(ggplot2)
  
  # create data frame (and indicate direction of foldChange?)
  myResults_df_full <- data.frame(myResults)
  myResults_df <- subset(myResults_df_full, myResults_df_full$padj < 0.05)
  myResults_df$Direction <- as.factor(as.character(myResults_df$log2FoldChange>0) )
  myResults_df$Gene <- row.names(myResults_df)
  
  ## Make a plotting variable that indicates if gene is a sex gene or not
  myResults_df$ColorFill <- 'Other Gene'
  myResults_df$ColorFill[myResults_df$Gene %in% highlightGenes[,1]] <- highlightGeneName
  myResults_df$ColorFill <- as.factor(myResults_df$ColorFill)
  
  ## Order by log2FoldChange so that becomes order it is plotted in
  ### the ordering of the levels within a factor determines ordering of bars.
  ### Step One: order rows by log2FC
  myResults_df <- myResults_df[order(myResults_df$log2FoldChange, decreasing=TRUE) , ]
  
  ### Step Two: Here, use order of genes above (in step One) to determine orders of levels, 
  ### and therefore order of bars.
  myResults_df$Gene <- factor(myResults_df$Gene, levels=myResults_df$Gene)
  
  ## All genes with padj < .05 and Log2FC > threshold
  barplotData <- subset(myResults_df, subset = abs(myResults_df$log2FoldChange) > fcThreshold)
  
  ## plot the plot
  p <- ggplot( barplotData, aes(x=Gene,y=log2FoldChange, fill = ColorFill,) ) +
    geom_bar(position=position_dodge(), stat="identity",
             color = "black", size = 0.3) +
    scale_y_continuous(breaks=0:20*4) +
    theme_bw() +
    theme(axis.text.x = element_text(angle=90, hjust=1, size=15),
          axis.text.y = element_text(size=20)) +
    geom_hline(aes(yintercept = fcThreshold), colour="red") +
    geom_hline(aes(yintercept = -fcThreshold), color= "red") +
    xlab("Genes") +
    ylab("Log2 Fold Change")+
    ggtitle(myTitle) +
    scale_fill_manual(values=c('#FEE08B','#3288BD'))
  # #scale_fill_hue(name="16p11.2 Region Gene Status", labels='CNVgene') +
  
  print(p)
  
  ggsave(filename=paste0('theoBarPlot_', highlightGeneName,'_thresh', fcThreshold, '.svg'), plot=p, width=myWidth, height=myHeight, device='svg' )
}