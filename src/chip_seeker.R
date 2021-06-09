setwd("/Users/artemstreltsov/hse21_H3K9me3_ZDNA_human/src")

source('lib.R')

###

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
BiocManager::install("ChIPseeker")
BiocManager::install("clusterProfiler")
BiocManager::install("ChIPpeakAnno")
BiocManager::install("org.Hs.eg.db")


library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(clusterProfiler)
library(ChIPpeakAnno)

###

# NAME <- 'H3K9me3_H1.ENCFF678VNN.hg19'
# NAME <- 'H3K9me3_H1.ENCFF918VFL.hg19'
# NAME <- 'DeepZ'
NAME <- 'H3K9me3_H1.intersect_with_DeepZ'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')

###

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.annopie.pdf'))
plotAnnoPie(peakAnno)
dev.off()

peak <- readPeakFile(BED_FN)
pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
covplot(peak, weightCol="V5")
dev.off()