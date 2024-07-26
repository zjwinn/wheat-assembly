library(pafr)

args <- commandArgs(trailingOnly = TRUE)
paf <- args[1]
outjpg <- args[2]

ali <- read_paf(paf)

p <- plot_coverage(ali)

ggsave(filename = outjpg, plot = p)
