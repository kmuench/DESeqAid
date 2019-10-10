#' Add HUGO gene names to ensembl list
#'
#' You could just call DESeq() in your code... or you could call this nifty function, which
#' also saves the output to a table AND an R variable for later use
#'
#' Returns DESeq results object.
#'
#' @param my_df A data frame where rownames are ensembl genes
#' @param whichEnsembl which biomart dataset to draw from - e.g. "mmusculus_gene_ensembl"
#' @param transcript_or_gene "ensembl_gene_id" or "ensembl_transcript_id"
#' @keywords DESeq
#' @export
#' @examples
#'
#' new_results_df <- addHUGOnames(my_results_df, "mmusculus_gene_ensembl", 'ensembl_transcript_id')

# add hugo genes names to this to make intelligible
# learn how to use here: https://www.bioconductor.org/packages/devel/bioc/vignettes/biomaRt/inst/doc/biomaRt.html
# my_df: data frame containing expression data, columns = samples, rows=genes
addHUGOnames <- function(my_df, whichEnsembl, transcript_or_gene){
  library( "biomaRt" )
  my_df$ensembl <- sapply( strsplit( rownames(my_df), split="[.]" ), "[", 1 )
  ensembl = useMart( "ensembl", dataset = whichEnsembl )
  genemap <- getBM( attributes = c("ensembl_gene_id", "entrezgene_id","external_gene_name"), # c("ensembl_gene_id", "entrezgene","external_gene_name") OR c("ensembl_transcript_id", "ensembl_gene_id", "entrezgene", "hgnc_symbol")
                    filters = transcript_or_gene,
                    values = my_df$ensembl,
                    mart = ensembl )
  idx <- match( my_df$ensembl, genemap[, transcript_or_gene] )
  my_df$entrez <- genemap$entrezgene[ idx ]
  my_df$Gene <- genemap$external_gene_name[ idx ] #genemap$hgnc_symbol
  return(my_df)
}
