#' Add LFC Shrink
#'
#' Takes in DESeq results object and turns it into a nice data frame, complete with column for shrunken lfcs.
#' 
#' Returns data frame with DESeq results entries for each gene (significant and non-), with separate shrunken lfc column.
#' 
#' Generated in a rage when I got frustrated with trying to pass multiple objects in a list out of an R function.
#' One day, this may get folded into deseq_coef or deseq_contrasts.
#' 
#' 
#' @param myResults DESeq results object
#' @param dds DESeq Object
#' @param myContrast coefficient or contrast that you used to 
#' @keywords DESeq
#' @export
#' @examples
#' results_sex_df <- add_lfcShrink(results_sex, dds_sva, c('Sex', 'M', 'F'))

add_lfcShrink <- function(myResults, dds, myContrast){
  myResults_df <- data.frame(myResults)
  myResults_df$lfc_shrink <- lfcShrink(dds, contrast=myContrast) # one day do type='apeglm'
  return(myResults_df)
}
