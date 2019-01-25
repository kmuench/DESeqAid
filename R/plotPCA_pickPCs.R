#' Plot principal components analysis: DESeq2 method, but more than the first two PCs
#'
#' This function allows you to plot a Principal Components Analysis with more than the first two PCs.
#' It uses the same method implemented by DESeq (and is, in fact, an edited version of the plotPC function).
#' Code courtesy Santosh Anand: https://www.biostars.org/p/243695/
#' 
#' At some point, this code will be rewritten so you don't have to define your PCs of interest twice.
#' 
#' @param object DESeq object, e.g. DESeqTransform
#' @param intgroup Character string describing how you want to color the points
#' @param PC_A Character string with name of first PC to plot, e.g. 'PC2'
#' @param PC_B Character string with name of second PC to plot, e.g. 'PC3'
#' @param num_A Integer corresponding to number of PC_A to plot
#' @param num_B Integer corresponding to number of PC_B to plot
#' @param ntop Number of genes to use when calculating PCs
#' @param returnData Return PC data for plotting, or just use this plot?
#' @keywords DESeq2, PCA
#' @keywords RNA-Seq visualization
#' @export
#' @examples
#' plotPCA_pickPCs(dds_kal_vst_bc, 'PCR_integration', 'PC2', 'PC3', 2, 3, returnData=TRUE)
#' 

plotPCA_pickPCs <- function (object, intgroup = "condition", PC_A, PC_B, num_A, num_B, ntop = 500, returnData = FALSE) 
{
  rv <- rowVars(assay(object))
  select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, 
                                                     length(rv)))]
  pca <- prcomp(t(assay(object)[select, ]))
  percentVar <- pca$sdev^2/sum(pca$sdev^2)
  if (!all(intgroup %in% names(colData(object)))) {
    stop("the argument 'intgroup' should specify columns of colData(dds)")
  }
  intgroup.df <- as.data.frame(colData(object)[, intgroup, drop = FALSE])
  group <- if (length(intgroup) > 1) {
    factor(apply(intgroup.df, 1, paste, collapse = " : "))
  }
  else {
    colData(object)[[intgroup]]
  }
  d <- data.frame(PC_A = pca$x[, num_A], PC_B = pca$x[, num_B], group = group, 
                  intgroup.df, name = colData(object)[,1])
  colnames(d)[colnames(d)=="PC_A"] <- PC_A 
  colnames(d)[colnames(d)=="PC_B"] <- PC_B
  
  if (returnData) {
    attr(d, "percentVar") <- percentVar[1:2]
    return(d)
  }
  ggplot(data = d, aes_string(x = PC_A, y = PC_B, color = "group", label = "name")) + geom_point(size = 3) + xlab(paste0(PC_A, ": ", round(percentVar[1] * 100), "% variance")) + ylab(paste0(PC_B, ": ", round(percentVar[2] * 100), "% variance")) + coord_fixed() + geom_text_repel(size=3) 
  
}