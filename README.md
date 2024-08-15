# Wheat assembly workflow

1. Install software into a conda environment

```
conda create --name assembly_env
source activate assembly_env
conda install snakemake pbtk cutadapt hifiasm ragtag r-pafr
```

2. Clone the repository and edit config.yaml and snakemake_batch.sh files to fit your job.

3. Run snakemake

Use batch script to submit jobs to SLURM.

```
sbatch snakemake_batch.sh
```

Or, run snakemake locally.

```
snakemake --cores 'all' --configfile config.yml
```


