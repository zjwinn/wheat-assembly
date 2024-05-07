library(pafr)
library(gridExtra)
dir.create("plots")

ali_AGS = read_paf("AGS2000.scaffold.paf")
ali_Hil = read_paf("Hilliard.scaffold.paf")
ali_MO = read_paf("MO080104.scaffold.paf")
ali_IL = read_paf("IL02-18228.scaffold.paf")

p_AGS = plot_coverage(ali_AGS)
p_AGS = p_AGS + labs(title="AGS2000 contigs mapped to Attraktion", 
                     subtitle = "Uncovered regions of Attraktion are white")

p_Hil = plot_coverage(ali_Hil)
p_Hil = p_Hil + labs(title="Hilliard contigs mapped to Attraktion", 
                     subtitle = "Uncovered regions of Attraktion are white")

p_MO = plot_coverage(ali_MO)
p_MO = p_MO + labs(title="MO080104 contigs mapped to Attraktion", 
                    subtitle = "Uncovered regions of Attraktion are white")

p_IL = plot_coverage(ali_IL)
p_IL = p_IL + labs(title="IL02-18228 contigs mapped to Attraktion", 
                   subtitle = "Uncovered regions of Attraktion are white")

ggsave("plots/AGS2000 contig alignment to Attraktion.jpeg", plot = p_AGS)
ggsave("plots/Hilliard contig alignment to Attraktion.jpeg", plot = p_Hil)
ggsave("plots/MO080104 contig alignment to Attraktion.jpeg", plot = p_MO)
ggsave("plots/IL02-18228 contig alignment to Attraktion.jpeg", plot = p_IL)

#Plot all alignments at once
p_AGS = plot_coverage(ali_AGS) + labs(title="AGS2000")
p_Hil = plot_coverage(ali_Hil) + labs(title="Hilliard")
p_MO = plot_coverage(ali_MO) + labs(title="MO080104")
p_IL = plot_coverage(ali_IL) + labs(title="IL02-18228")

p_grid = grid.arrange(p_AGS, p_Hil, p_MO, p_IL)

ggsave("plots/Four lines contig alignment to Attraktion.jpeg", p_grid)
