#' Check Surrogate Variables
#'
#' Do your surrogate variables correlate to any known sources of variance in your dataset?
#' This function will help you visualize that.
#' 
#' @param myDESeqDataSetVar Imported DESeq data, dollar sign, sampleTable name you want to plot
#' @param svseq svseq object created with SVA package
#' @param nSurr number of surrogate variables contained within SVA package that you want to plot
#' @keywords SVA
#' @keywords Batch Correction
#' @export
#' @examples
#' checkSVs(myData$Sex, svseq, 3)


checkSVs <- function(MyDESeqDataSetVar, mySVseq, nSurr){
  par(mfrow = c(nSurr, 1), mar = c(3,1,1,1)) # import number of surrogate variables in
  
  for (i in 1:nSurr) {
    stripchart(mySVseq$sv[, i] ~ MyDESeqDataSetVar, vertical = TRUE, main = paste0("SV", i))
    abline(h = 0)
  }
}
