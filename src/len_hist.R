setwd("/Users/artemstreltsov/hse21_H3K9me3_ZDNA_human/src")

source('lib.R')

###

# NAME <- 'H3K9me3_H1.ENCFF678VNN.hg19'
# NAME <- 'H3K9me3_H1.ENCFF918VFL.hg19'
NAME <- 'DeepZ.bed'

###

bed_df <- read.delim(paste0(DATA_DIR, NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = OUT_DIR)