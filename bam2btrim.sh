#!/bin/bash

#SBATCH --job-name="bam2trim_MO"                  #name of the job submitted
#SBATCH -p atlas                         #name of the queue you are submitting job to
#SBATCH -N 1                            #number of nodes in this job
#SBATCH -n 48                           #number of cores/tasks in this job
#SBATCH -t 24:00:00                     #time allocated for this job hours:mins:seconds
#SBATCH -A gbru_wheat2
#SBATCH --mail-user=mrwillma@ncsu.edu   #email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o "stdout.%x.%j.%N"               #standard out %j adds job number to outputfile name and %N adds the node
#SBATCH -e "stderr.%x.%j.%N"               #optional but it prints our standard error

CV=MO080104

INDIR=/project/gbru_wheat2/fhb/Raw_Hifi/$CV/Bam
OUTDIR_BAM=/90daydata/gbru_wheat2/fhb/Raw_Hifi/$CV/Bam
OUTDIR_FASTQ=/90daydata/gbru_wheat2/fhb/Raw_Hifi/$CV/Fastq
OUTDIR_TRIM=/90daydata/gbru_wheat2/fhb/Processed_Hifi/$CV/Fastq_btrim

MERGEOUT=$OUTDIR_BAM/$CV.merged.bam
FASTQOUT=$OUTDIR_FASTQ/$CV.reads
BTRIMPASS=$OUTDIR_TRIM/$CV.reads_pass.fastq
BTRIMFAIL=$OUTDIR_TRIM/$CV.reads_fail.fastq

BTRIMPATH=$HOME/software/btrim
PBTKPATH=$HOME/software/pbtk

mkdir -p $OUTDIR_BAM
mkdir -p $OUTDIR_FASTQ
mkdir -p $OUTDIR_TRIM


echo "pbmerge $(date)"
$PBTKPATH/pbmerge -j 48 -o $MERGEOUT $INDIR/*.bam

echo "bam2fastq $(date)"
$PBTKPATH/bam2fastq -j 48 -o $FASTQOUT -c 1 $MERGEOUT

echo "btrim $(date)"
$BTRIMPATH/btrim -p $BTRIMPATH/patterns.txt -t $FASTQOUT.fastq.gz -o $BTRIMFAIL -K $BTRIMPASS -3 -z -e 0 -v 3 -s $OUTDIR_TRIM/reads_summary.txt > $OUTDIR_TRIM/reads.btrim_summary.txt

#echo "gzip $(date)"
#gzip $BTRIMPASS

echo "Done $(date)"