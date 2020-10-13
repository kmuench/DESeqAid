# DESeqAid
## Functions to make my DESeq2 life easier

[ Introduction ](#intro) | [ Usage ](#usage) | [ Examples ](#examples) | [ Reflections ](#reflections) 

<a name="intro"></a>
## Introduction
During my PhD, I did a fair amount of RNA-Seq analysis, often using DESeq2. I created this library to speed my mRNA-Seq analysis and make it slightly more modular. These are mostly designed to make my life slightly easier, e.g. by bunding my visualization settings into a single function, or processing the DESeq output in the way I like.

I rely on this library for my [16p paper code](https://github.com/kmuench/16p_resource).

Many thanks to Hilary Parker for enriching the community by providing this easy-to-read guide to [writing R packages](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/).

### Data exploration
- checkSVs(): explore whether your surrogate variables (from SVA) correlated with known sources of variance
- distPCA(): plots Principal Component Analysis
- plotPCA_pickPCs(): plots Principal Component Analysis using the DESeq2 method, but lets you  pick which principal components to visualize
- sampSimilarityHeatmap(): heatmap of sample correlation

### Functions for cleaning up the DESeq output a little
- deseq_coef(): DESeq output given a DESeq coefficient
- deseq_contrasts(): DESeq output given a contrast specified in design matrix
- add_lfcShrink(): adds shrunken log FCs to DESeq results table
- addHUGOnames(): if you did DE using ensembl genes, adds a column of corresponding HUGO gene names 

### Functions for visualizing DESeq output
- fcSortBarPlot_lfcShrink()
- DE_heatmap(): makes a heatmap from a count table in the way I wanted at that time
- theoBarPlot(): ordered bar plot of gene expression, named after the advisor who encouraged its development
- fcSortBarPlot_lfcShrink(): The Theo Palmer bar plot, but using shrunken logFCs
- heatmapSexGenes(): heatmap of sex-linked genes
- makeVolcanoPlot(): volcano plot from DESeq output

<a name="usage"></a>
## Usage

### Install

First - of course - clone the repo:

```
git clone https://github.com/kmuench/DESeqAid.git
```

In order to load this package, you'll need to install the devtools package. In R:

```
install.packages("devtools")
library("devtools")
```

Finally, in R, navigate to the same working directory as the DESeqAid dir. In R:

```
install("DESeqAid")
```

Great! Now it's installed, and if you want to load it in the future, simply add to your R script:

```
library("DESeqAid")
```

<a name="examples"></a>
### Examples

You can find example uses of this library throughout my 16p_resource code - for example, 
- makeVolcanoPlot() in line 159 of the [DESeq script for Figure 5](https://github.com/kmuench/16p_resource/blob/master/scripts/figure5/deseq.Rmd).
- deseq_contrasts() in line 83 of the [DESeq script for Figure 5](https://github.com/kmuench/16p_resource/blob/master/scripts/figure5/deseq.Rmd).
- fcSortBarPlot_lfcShrink() in line 174 of the [DESeq script for Figure 5](https://github.com/kmuench/16p_resource/blob/master/scripts/figure5/deseq.Rmd).
- distPCA() throughout [the setup script for Figure 6](https://github.com/kmuench/16p_resource/blob/master/scripts/figure6/tximport_setup.Rmd).

<a name="reflections"></a>
## To-Do List
- Make the functions more flexible so that they're not so wedded to a particular formatting of data
- Include more flags in arguments that let you use different versions of similar code (e.g., labels or no)
- You call this modular, past me? This could be more modular
