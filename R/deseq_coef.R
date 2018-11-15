#'
#' You could just call DESeq() in your code... or you could call this nifty function, which 
#' also saves the output to a table AND an R variable for later use.
#' 
#' Returns DESeq results object.
#' 
#' This one takes in a coefficient from matrix(resultsNames(dds_sva)). There is also deseq_contrasts if you want to compare specific known groups.
#' 
#' @param dds DESeq object
#' @param myAlpha number - threshold for calling genes significant
#' @param coefficient coefficient for which you want DE gene list. To see all available, enter matrix(resultsNames(dds_sva)) in command line
#' @param nickname Character string - what do you want these results to be called
#' @param currDate Character string - code representing date on which you did this analysis
#' @param expName Character string - code representing this whole set of analyses 
#' @param genesOfInterest Dataframe column listing genes you might want to count in plot, e.g. sex marker genes
#' @keywords DESeq
#' @export
#' @examples
#' results_SexEffect_mainEffect <- deseq_contrasts(dds_sva, 0.05, 'SexF.TimepointSecond.Trimester', 'results_SexEffect_mainEffect', '20180814', 'exploreNewData', amySexGenes[,2])

deseq_coef <- function(dds, myAlpha, coefficient, nickname, currDate, expName, amySexGenes){
  
  # for clarity in output - announce analysis
  print('...')
  print(paste0('Analysis for coefficient: ', nickname))
  
  # Generate DE gene list
  #myResults <- results(dds, alpha=myAlpha, name=c(coefficient), independentFiltering = FALSE)
  myResults <- lfcShrink(dds, coef=c(coefficient), type='apeglm')
  print(summary(myResults))
  
  # Make an MA plot
  plotMA(myResults)
  
  # make into a function, add HUGO names
  myResults_df <- data.frame(myResults) # make conditional loop that includes hugoNames if not hugoNames
  
  # write to table
  write.table(myResults_df, paste0(currDate,'_', expName, '_deseqOutput_', nickname, '.txt'), sep="\t", quote=FALSE, row.names=FALSE, col.names=FALSE)
  
  # Sanity check: Are any sex genes DE?
  print('Are any sex genes in the DE list?')
  print(myResults_df[row.names(myResults_df) %in% amySexGenes,])
  
  # Save R variable 
  save(myResults_df, file=paste0(currDate,'_', expName, '_deseqOutput_', nickname, '.RData'))
  
  # return results for later use
  return(myResults)
  
}
