#' Examine sample similarity with heatmap
#'
#' This function helps you identify which samples are correlated with one another.
#' Alongside a heatmap representation of inter-sample correlation, it plots colorful bars representing factors in your sampleTable.
#' This helps you identify by eye if your samples are clustering according to a certain factor, e.g. sample Sex.
#' 
#' @param rawCounts A dataframe representing counts in your dataset. Could be normalized (rlog(DESeqobject)) or not (counts(DESeqObject))
#' @param sampleTable Sample table used to import data in DESeq's DESeqDataSetFromHTSeqCount function
#' @param factorsToPlot character list of sampleTable column names you want to plot alongside heatmap
#' @param sampleTableNameCol the column of sampleTable with the sample names you want plotted. MUST MATCH COLNAMES OF rawCounts
#' @keywords DESeq2
#' @keywords Exploratory Data Analysis
#' @export
#' @examples
#' sampSimilarityHeatmap(data.frame(counts(myData)), sampleTable, c('Sex', 'Timepoint', 'Condition'), sampleTable$FileName)

sampSimilarityHeatmap <- function(rawCounts, sampleTable, factorsToPlot, sampleTableNameCol ){
  library(pheatmap)
  
  # create annotations
  my_pheno_col <- data.frame(sampleTable[,factorsToPlot])
  row.names(my_pheno_col) <- sampleTableNameCol
  
  # plot pretty heatmap and add annotations
  pheatmap(cor(rawCounts),  annotation_row = my_pheno_col)
  
}
