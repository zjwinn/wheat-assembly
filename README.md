# Wheat assembly workflow

## 1. bam2btrim.sh

__Input:__

- PacBio CCS in BAM format.

__Output:__

- Adapter-filtered sequences in FASTQ format.

__Requirements:__

- btrim binary, http://graphics.med.yale.edu/trim/
- adapter sequences, patterns.txt
   

## 2. Hifiasm.sh

__Input:__

- Adapter-filtered PacBio CCS in FASTQ format.

__Output:__

- Contig assembly
- Basic stats

__Requirements:__

- Hifiasm
- BBTools
     

## 3. Ragtag.sh

__Input:__

- Contig assembly

__Output:__

- Scaffold assembly
- PAF alignment file

__Requirements:__

- Ragtag
- minimap2
- Reference assembly
- replace_fasta_headers.py (Replaces Attraktion reference names in assembly FASTA using Attraktion_Ragtag_nameswap.txt)
- replace_words.py (Replaces Attraktion reference names in PAF using Attraktion_paf_nameswap.txt)
- Attraktion_Ragtag_nameswap.txt
- Attraktion_paf_nameswap.txt


## 4. plot_coverage.R

__Input:__

- PAF alignment file

__Output:__

- Coverage plots of contigs aligned to reference

__Requirements:__

- R packages: pafr, gridExtra

## 5. Busco.sh

__Input:__

- Scaffolded assembly

__Output:__

- Full assembly BUSCO stats (all contigs)
- Scaffolded assembly BUSCO stats (sans unscaffolded contigs)

__Requirements:__

- BUSCO

# Wheat annotation workflow

## 1. RepeatModeler-chrsA.sh

__Input:__

- Scaffold assembly

__Output:__

- Repeat/TE models for A subgenome

__Requirements:__

- RepeatModeler
- subgenome_A.txt (Used to subset A subgenome from full scaffolded assembly)