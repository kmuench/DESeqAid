#' Perform DESeq using contrasts
#'
#' You could just call DESeq() in your code... or you could call this nifty function, which 
#' also saves the output to a table AND an R variable for later use
#' 
#' Returns DESeq results object.
#' 
#' @param dds DESeq object
#' @param myAlpha number - threshold for calling genes significant
#' @param myContrast c('Factor To Study in Contrast', 'Level1', 'Level2')
#' @param nickname Character string - what do you want these results to be called
#' @param currDate Character string - code representing date on which you did this analysis
#' @param expName Character string - code representing this whole set of analyses 
#' @param genesOfInterest Dataframe column listing genes you might want to count in plot, e.g. sex marker genes
#' @keywords DESeq
#' @export
#' @examples
#' results_SexEffect_mainEffect <- deseq_contrasts(dds_sva, 0.05, c("Sex", "F", "M"), 'results_SexEffect_mainEffect', '20180814', 'exploreNewData', amySexGenes[,2])


deseq_contrasts <- function(dds, myAlpha, myContrast, nickname, currDate, expName, genesOfInterest){
  
  # for clarity in output - announce analysis
  print('...')
  print(paste0('Analysis for Contrast: ', nickname))
  
  # Generate DE gene list
  myResults <- results(dds, alpha=myAlpha, contrast=myContrast, independentFiltering = FALSE)
  print(summary(myResults))
  
  myResults <- lfcShrink(dds, contrast=myContrast)
  myResults_df <- data.frame(myResults)
  
  # # make into a function, add HUGO names
  # myResults_df <- data.frame(myResults) # make conditional loop that includes hugoNames if not hugoNames
  # 
  # print('made df OK...')
  # myResults_shrunk <- lfcShrink(dds, contrast=myContrast) # one day do type='apeglm'
  # myResults_shrunk_df <- data.frame(myResults_shrunk)
  
  ## Make an MA plot
  plotMA(myResults)
  
  
  # write to table
  #write.table(myResults_df, paste0(currDate,'_', expName, '_deseqOutput_regularLFC_', nickname, '.txt'), sep="\t", quote=FALSE, row.names=TRUE, col.names=TRUE)
  write.table(myResults_df, paste0(currDate,'_', expName, '_deseqOutput_shrunkLFC_', nickname, '.txt'), sep="\t", quote=FALSE, row.names=TRUE, col.names=TRUE)
  
  # Sanity check: Are any sex genes DE?
  print('Are any of my genes of interest in the DE list?')
  print(myResults_df[row.names(myResults_df) %in% genesOfInterest,])
  
  # Save R variable 
  save(myResults_df, file=paste0(currDate,'_', expName, '_deseqOutput_', nickname, '.RData'))
  
  # return results for later use
  return(myResults)
  
}

