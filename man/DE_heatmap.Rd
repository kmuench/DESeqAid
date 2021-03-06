% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DE_heatmap.R
\name{DE_heatmap}
\alias{DE_heatmap}
\title{Plot differentially expressed genes with a heatmap}
\usage{
DE_heatmap(rawCounts, sampleTable, factorsToPlot, sampleTableNameCol,
  myWidth, myHeight, myFilename, myColors, myAnnotationColors,
  rowsplit = NULL)
}
\arguments{
\item{rawCounts}{A dataframe representing counts in your dataset. Could be normalized (rlog(DESeqobject)) or not (counts(DESeqObject))}

\item{sampleTable}{Sample table used to import data in DESeq's DESeqDataSetFromHTSeqCount function}

\item{factorsToPlot}{character list of sampleTable column names you want to plot alongside heatmap}

\item{sampleTableNameCol}{the column of sampleTable with the sample names you want plotted. MUST MATCH COLNAMES OF rawCounts}

\item{myWidth}{Width of svg output in inches}

\item{myHeight}{Height of svg output in inches}

\item{myFilename}{Name of svg file output}

\item{myColors}{Color brewer palatte, or character vector of colors. This feeds into "colors" flag of pheatmap. Check out RColorBrewer for more colors}

\item{rowsplit}{If you want clustering, indicate a number where you want the split to occur in the rows}
}
\description{
This function makes a pretty heatmap illustrating how your genes are clustering.
}
\examples{
DE_heatmap(myData_moduleGenes, sampleTable_plus, c('Genotype', 'PCR_integration', 'plas_backbone', 'plas_shp', 'transcripts_shp'), 
'DESeqAnalysisID', 30,15, 'Expression_YlOrRed.png', myColors =  colorRampPalette(rev(brewer.pal(n = 7, name = "YlOrRd")))(100))
}
\keyword{DE}
\keyword{DESeq2}
\keyword{Visualization}
