#!/bin/bash

#SBATCH --job-name="RepeatModeler_chrsA"            #name of the job submitted
#SBATCH -p atlas                      #name of the queue you are submitting job to
#SBATCH -A gbru_wheat2
#SBATCH -N 1                            #number of nodes in this job
#SBATCH -n 48                           #number of cores/tasks in this job
#SBATCH --mem=0
#SBATCH -t 4-00:00:00                                   #time allocated for this job hours:mins:seconds
#SBATCH --mail-user=mrwillma@ncsu.edu   #email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o "stdout.%x.%j.%N"               #standard out %x adds job name and %j adds job number to outputfile name and %N adds the node
#SBATCH -e "stderr.%x.%j.%N"               #optional but it prints our standard error

CV=MO080104

INFASTA=/90daydata/gbru_wheat2/$CV/Assembly/RagTag/$CV.scaffold.fasta
OUTDIR=/90daydata/gbru_wheat2/$CV/Annotation/RepeatModeler_subgenome_A

mkdir -p $OUTDIR
cd $OUTDIR

INFASTA=/90daydata/gbru_wheat2/$CV/Assembly/RagTag/$CV.scaffold.fasta

module load miniconda
source activate /project/gbru_wheat2/fhb/conda/repeatmodeler_env
module load seqkit/2.3.1

echo subset A subgenome
date
seqkit grep -rp '\dA' $INFASTA > $CV.chrsA.fasta

echo Build database
date
BuildDatabase -name chrsA $CV.chrsA.fasta

echo Database done
date

echo Run RepeatModeler
date

RepeatModeler -database chrsA -threads 48 -LTRStruct > $CV.chrsA.log

echo Done
date