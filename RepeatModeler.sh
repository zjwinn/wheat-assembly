#!/bin/bash

#SBATCH --job-name="RepeatModeler_MO"            #name of the job submitted
#SBATCH -p medium                      #name of the queue you are submitting job to
#SBATCH -A gbru_wheat2
#SBATCH -N 1                            #number of nodes in this job
#SBATCH -n 72                           #number of cores/tasks in this job
#SBATCH --mem=0
#SBATCH -t 7-00:00:00                                   #time allocated for this job hours:mins:seconds
#SBATCH --mail-user=mrwillma@ncsu.edu   #email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o "stdout.%x.%j.%N"               #standard out %x adds job name and %j adds job number to outputfile name and %N adds the node
#SBATCH -e "stderr.%x.%j.%N"               #optional but it prints our standard error

CV=MO080104

INFASTA=/90daydata/gbru_wheat2/$CV/Assembly/RagTag/$CV.scaffold.fasta
OUTDIR=/90daydata/gbru_wheat2/$CV/Annotation/RepeatModeler

mkdir -p $OUTDIR
cd $OUTDIR

module load repeatmodeler/2.0.4
module load seqkit/2.4.0

echo "subset by subgenome"
date
seqkit grep -rp '\dA' $INFASTA > $CV.chrsA.fasta
seqkit grep -rp '\dB' $INFASTA > $CV.chrsB.fasta
seqkit grep -rp '\dD' $INFASTA > $CV.chrsD.fasta
seqkit grep -rp 'ptg' $INFASTA > $CV.chr0.fasta


echo "Build database: chrsA"
date
BuildDatabase -name chrsA $CV.chrsA.fasta

echo "Build database: chrsB"
date
BuildDatabase -name chrsB $CV.chrsB.fasta

echo "Build database: chrsD"
date
BuildDatabase -name chrsD $CV.chrsD.fasta

echo "Build database: chr0"
date
BuildDatabase -name chr0 $CV.chr0.fasta

echo "Databases done"
date


echo "Run RepeatModeler: chrsA"
date
RepeatModeler -database chrsA -threads 72 -LTRStruct > $CV.chrsA.log

echo "Run RepeatModeler: chrsB"
date
RepeatModeler -database chrsB -threads 72 -LTRStruct > $CV.chrsB.log

echo "Run RepeatModeler: chrsD"
date
RepeatModeler -database chrsD -threads 72 -LTRStruct > $CV.chrsD.log

echo "Run RepeatModeler: chr0"
date
RepeatModeler -database chr0 -threads 72 -LTRStruct > $CV.chr0.log

echo "Done"
date
