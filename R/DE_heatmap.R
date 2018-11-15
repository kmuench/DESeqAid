#' Plot differentially expressed genes with a heatmap
#'
#' This function makes a pretty heatmap illustrating how your genes are clustering.
#' 
#' @param rawCounts A dataframe representing counts in your dataset. Could be normalized (rlog(DESeqobject)) or not (counts(DESeqObject))
#' @param sampleTable Sample table used to import data in DESeq's DESeqDataSetFromHTSeqCount function
#' @param factorsToPlot character list of sampleTable column names you want to plot alongside heatmap
#' @param sampleTableNameCol the column of sampleTable with the sample names you want plotted. MUST MATCH COLNAMES OF rawCounts
#' @param myWidth Width of svg output in inches
#' @param myHeight Height of svg output in inches
#' @param myFilename Name of svg file output
#' @param myColors Color brewer palatte, or character vector of colors. This feeds into "colors" flag of pheatmap. Check out RColorBrewer for more colors
#' @param rowsplit If you want clustering, indicate a number where you want the split to occur in the rows
#' @keywords DESeq2
#' @keywords DE Visualization
#' @export
#' @examples
#' DE_heatmap(myData_moduleGenes, sampleTable_plus, c('Genotype', 'PCR_integration', 'plas_backbone', 'plas_shp', 'transcripts_shp'), 
#' 'DESeqAnalysisID', 30,15, 'Expression_YlOrRed.png', myColors =  colorRampPalette(rev(brewer.pal(n = 7, name = "YlOrRd")))(100))


DE_heatmap <- function(rawCounts, sampleTable, factorsToPlot, sampleTableNameCol, myWidth, myHeight, myFilename, myColors, myAnnotationColors, rowsplit = NULL){
  library(pheatmap)
  
  # create annotations
  my_pheno_col <- data.frame(sampleTable[,factorsToPlot])
  row.names(my_pheno_col) <- sampleTable[,sampleTableNameCol]
  colnames(my_pheno_col) <- factorsToPlot
  
  
  # # plot pretty heatmap and add annotations
  # if(is.null(rowsplit)) {
  #   pheatmap(rawCounts,  
  #            annotation_row = my_pheno_col, 
  #            cutree_rows = 2, 
  #            filename = myFilename, 
  #            width = myWidth, 
  #            height = myHeight, 
  #            color = myColors,
  #            annotation_colors = myAnnotationColors) 
  # } else {
  #   pheatmap(rawCounts,  
  #            annotation_row = my_pheno_col, 
  #            color=myColors, 
  #            filename = myFilename, 
  #            width = myWidth, 
  #            height = myHeight, 
  #            cluster_rows =  = FALSE, 
  #            gaps_row = rowsplit,
  #            annotation_colors = myAnnotationColors) 
  # }
  
  # plot pretty heatmap and add annotations (uncomment for inverted)
  if(is.null(rowsplit)) {
    pheatmap(rawCounts,  
             annotation_row = my_pheno_col, 
             cutree_rows = 2, 
             filename = myFilename, 
             width = myWidth, 
             height = myHeight, 
             color = myColors,
             annotation_colors = myAnnotationColors) 
  } else {
    pheatmap(rawCounts,  
             annotation_col = my_pheno_col, 
             color=myColors, 
             filename = myFilename, 
             width = myWidth, 
             height = myHeight, 
             cluster_cols = FALSE, 
             gaps_col = rowsplit,
             annotation_colors = myAnnotationColors) 
  }
  
  # save as svg
  
}


