#!/bin/bash

#SBATCH --job-name="ragtag_MO2Attraktion"
#SBATCH -A gbru_wheat2
#SBATCH -N 1
#SBATCH -n 48
#SBATCH --mem=0
#SBATCH -p atlas
#SBATCH --time=2-00:00:00
#SBATCH --mail-user=mrwillma@ncsu.edu   # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o "stdout.%x.%j.%N"               #standard out %x adds job name and %j adds job number to outputfile name and %N adds the node
#SBATCH -e "stderr.%x.%j.%N"               #optional but it prints our standard error

module load miniconda
source activate ragtag_env
echo Ragtag
ragtag.py --version
echo minimap2
minimap2 --version

CV=MO080104

REFDIR=/project/gbru_wheat2/ref/Attraktion_ENA
REF=$REFDIR/GCA_918797515.1.fasta
QUERY=/90daydata/gbru_wheat2/$CV/Assembly/Hifiasm/$CV.asm.bp.p_ctg.fasta
OUTDIR=/90daydata/gbru_wheat2/$CV/Assembly/RagTag

date
# -r flag infers gap sizes: min=100bp max=100,000,000bp; -C concatenates unplaced contigs to chr0
ragtag.py scaffold --mm2-params '-I 200g -x asm5' -t 32 -r -g 100 -m 100000000 -C -o $OUTDIR $REF $QUERY
date

#Rename headers
cd $OUTDIR
cp $REFDIR/Attraktion_Ragtag_nameswap.txt .
awk -v var="$CV" -F'\t' -vOFS='\t' '{ $2 = var "_" $2 }1' < Attraktion_Ragtag_nameswap.txt > Attraktion_Ragtag_nameswap.$CV.txt

$HOME/software/replace_fasta_headers.py ragtag.scaffold.fasta Attraktion_Ragtag_nameswap.$CV.txt $CV.scaffold.fasta

#Rename paf ref names
cd $OUTDIR
cp $REFDIR/Attraktion_paf_nameswap.txt .
$HOME/software/replace_words.py  ragtag.scaffold.asm.paf Attraktion_paf_nameswap.txt $CV.scaffold.paf