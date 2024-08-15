The assembly / annotation workflow is currently divided into sections managed by [Snakemake](https://snakemake.readthedocs.io/en/stable/).

All sections of this repository are currently under development.

## TO DO:

- Move annotation workflow to its own repo.

- Update vrn BLAST to include VRN2 and VRN3.

- Define input directory (Raw_Bam) in config.yml.

- Move scripts and files to parent directory.

- Move rules to .smk files.



# Wheat assembly workflow

1. Install software into conda environment

```
conda create --name assembly_env
source activate assembly_env
conda install snakemake pbtk cutadapt hifiasm ragtag r-pafr
```

2. Clone the repository and edit config.yaml and snakemake_batch.sh files to fit your job.

3. Run snakemake

Use batch script to submit jobs to SLURM.

```
cd /path/Accession/1_Assembly
sbatch snakemake_batch.sh
```

Or, run snakemake locally.

```
cd /path/Accession/1_Assembly
snakemake --cores 'all' --configfile config.yml
```


