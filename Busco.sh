#!/bin/bash

#SBATCH --job-name="busco_MO"     #name of the job submitted
#SBATCH -p atlas              #name of the queue you are submitting job to
#SBATCH -A gbru_wheat2
#SBATCH -N 1                  #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 20 cores with 2 threads per
#SBATCH --mem=0
#SBATCH -t 7-00:00:00         #time allocated for this job hours:mins:seconds
#SBATCH --mail-user=mrwillma@ncsu.edu   #email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o "stdout.%x.%j.%N"  #standard out %j adds job number to outputfile name and %N adds the node
#SBATCH -e "stderr.%x.%j.%N"  #optional but it prints our standard error

module load miniconda
source activate busco_env
busco --version
module load seqkit

CV=MO080104

INDIR=/90daydata/gbru_wheat2/$CV/Assembly/RagTag
OUTDIR=/90daydata/gbru_wheat2/$CV/Assembly/BUSCO

mkdir $OUTDIR
cd $INDIR

#Remove chr0
seqkit grep -v -p Chr0_RagTag $CV.scaffold.fasta > $CV.scaffold.noChr0.fasta

cd $OUTDIR

echo Running BUSCO on assembly chromosomes
date
busco -i $INDIR/$CV.scaffold.noChr0.fasta -c 48 -l poales_odb10 -o noChr0_$CV -m genome

echo Running BUSCO on full assembly, including chr0
date
busco -i $INDIR/$CV.scaffold.fasta -c 48 -l poales_odb10 -o allChr_$CV -m genome
date
