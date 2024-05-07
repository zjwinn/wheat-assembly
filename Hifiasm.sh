#!/bin/bash

#SBATCH --job-name="Hifiasm_MO"            #name of the job submitted
#SBATCH -p bigmem                      #name of the queue you are submitting job to
#SBATCH -A gbru_wheat2
#SBATCH -N 1                            #number of nodes in this job
#SBATCH -n 40                           #number of cores/tasks in this job
#SBATCH -t 7-00:00:00                                   #time allocated for this job hours:mins:seconds
#SBATCH --mail-user=mrwillma@ncsu.edu   #email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o "stdout.%x.%j.%N"               #standard out %x adds job name and %j adds job number to outputfile name and %N adds the node
#SBATCH -e "stderr.%x.%j.%N"               #optional but it prints our standard error

CV=MO080104
INPUT=/90daydata/gbru_wheat2/fhb/Processed_Hifi/$CV/Fastq_btrim/$CV.reads_pass.fastq
OUTDIR=/90daydata/gbru_wheat2/Assembly/$CV/Hifiasm
mkdir -p $OUTDIR
module load miniconda/4.12.0
source activate hifiasm_env

# Assemble inbred/homozygous genome (-l0 disables duplication purging)
echo "Assemble contigs with hifiasm"
hifiasm -version
date
hifiasm -o $OUTDIR/$CV.asm -t 40 -l0 $INPUT

cd $OUTDIR

echo "Extract fasta from primary contig gfa"
date
awk '/^S/{print ">"$2;print $3}' $CV.asm.bp.p_ctg.gfa > $CV.asm.bp.p_ctg.fasta

echo "Calculate assembly stats"
stats.sh -version
date
stats.sh -Xmx800g in=$CV.asm.bp.p_ctg.fasta out=$CV.asm.bp.p_ctg.stats

echo "Done"
date
