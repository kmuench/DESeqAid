#' PCA Plot
#'
#' Plots a principal components analysis you've already performed on your data.
#' 
#' @param cds.pca x field of cds.pca, output of prcomp() function
#' @param condition column of sampleTable data frame (required for DESeq import) with the factor you want to use to color points
#' @param colorCondName Character string - what do you want the point-coloring factor to be called?
#' @param PC_A Character string - which PC to be plotted on X axis, e.g. 'PC1'
#' @param PC_B Character string - which PC to be plotted on Y axis, e.g. 'PC2'
#' @param title Character string - title of plot
#' @keywords Exploratory Data Analysis
#' @keywords DESeq
#' @export
#' @examples
#' distPCA(as.data.frame(cds.pca.rld_noBatchCorrect$x), sampleTable$Multiplex, 'Multiplex', 'PC1', 'PC2', PCA of KM 16p NPC \nExpression Data (HTSeq/STAR Pipeline, \nAfter RLE Normalization')


distPCA <- function(cds.pca, condition, colorCondName, PC_A, PC_B, title){ 
  # Declare needed libraries
  library(ggrepel)
  library(ggplot2)
  
  print('starting PCA plot...')
  # create data frame with scores
  scores <- as.data.frame(cds.pca)
  print(rownames(scores))


  # # plot of PCs - uncomment for labels
  # p= ggplot(data = as.data.frame(cds.pca),
  #           aes_string(x = PC_A, y = PC_B ) ) +
  #   geom_point() +
  #   geom_text_repel(size = 5, aes(label = rownames(as.data.frame(cds.pca)),
  #                                 colour = factor(condition),
  #                                 fontface='bold')) +
  #   geom_hline(yintercept = 0, colour = "gray65") +
  #   geom_vline(xintercept = 0, colour = "gray65") +
  #   scale_colour_discrete(name=colorCondName,
  #                         l=40) +
  #   ggtitle(title)
  # print(p)

  
  
  
  # plot of PCs - uncomment for shapes
  p= ggplot(data = as.data.frame(cds.pca),
            aes_string(x = PC_A, y = PC_B, group=factor(condition) ) ) +
    geom_hline(yintercept = 0, colour = "gray65") +
    scale_fill_discrete(name = colorCondName) +
    labs(color = colorCondName, shape = colorCondName) +
    geom_vline(xintercept = 0, colour = "gray65") +
    geom_point(aes(color=factor(condition), shape=factor(condition), size = factor(condition)) ) +
    ggtitle(title) +
    theme(axis.text.x = element_text(face="bold", size=14),
          axis.text.y = element_text(face="bold", size=14)) +
    theme_bw() +
    scale_color_manual(values=c("#3288BD", "#D53E4F", "#000000", '#a6cee3', '#1f78b4', '#b2df8a',
                                '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f', '#ff7f00', '#cab2d6',
                                '#6a3d9a', '#ffff99', '#b15928', '#8dd3c7', '#d9d9d9', rep('#000000', 100)) ) +
    scale_size_manual(values=c(6,7,rep(6,100))) + # because I want the triangles to be a little bigger but all others can be same size, 6
    scale_shape_manual(values=c(c(16:22, 1:15,23:100 )))
  print(p)

  # save plot
  ggsave(file=paste0(title,"_",colorCondName,'_',PC_A,'_',PC_B,".svg"), plot=p, width=12, height=10)

}
