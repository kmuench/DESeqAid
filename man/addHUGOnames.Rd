% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/addHUGOnames.R
\name{addHUGOnames}
\alias{addHUGOnames}
\title{Add HUGO gene names to ensembl list}
\usage{
addHUGOnames(my_df, whichEnsembl, transcript_or_gene)
}
\arguments{
\item{my_df}{A data frame where rownames are ensembl genes}

\item{whichEnsembl}{which biomart dataset to draw from - e.g. "mmusculus_gene_ensembl"}

\item{transcript_or_gene}{"ensembl_gene_id" or "ensembl_transcript_id"}
}
\description{
You could just call DESeq() in your code... or you could call this nifty function, which 
also saves the output to a table AND an R variable for later use
}
\details{
Returns DESeq results object.
}
\examples{

new_results_df <- addHUGOnames(my_results_df, "mmusculus_gene_ensembl", 'ensembl_transcript_id')
}
\keyword{DESeq}
