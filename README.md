# DESeqAid
## Functions to make my DESeq2 life easier

[ Introduction ](#intro) | [ Usage ](#usage) | [ Examples ](#examples) | [ Reflections ](#reflections) 

<a name="intro"></a>
## Introduction
During my PhD, I did a fair amount of RNA-Seq analysis, often using DESeq2. I created this library to speed my mRNA-Seq analysis and make it slightly more modular.

I rely on this library for my [16p paper code]().

Many thanks to Hilary Parker for enriching the community by providing this easy-to-read guide to [writing R packages](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/).

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
install("cats")
```

### Import

<a name="examples"></a>
## Examples

<a name="reflections"></a>
## To-Do List
- Make the functions more flexible so that they're not so wedded to a particular formatting of data
- Include more flags in arguments that let you use different versions of similar code (e.g., labels or no)
- You call this modular, past me? This could be more modular
