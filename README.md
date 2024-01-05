# Dihaploid analysis

This repository contains all the code used to carry out the dihaploid genome assembly and analysis.

To download this repository, simply run the code:

```
git clone https://github.com/SwiftSeal/vikrant_assembly.git
```

This will download the code to your current repository, ideally keep it in your scratch directory.

## Conda environments

The conda environment recipes used in this analysis are stored under the `environments/` directory.
To install a conda environment, run the following code:

```
conda env create -f environments/vikrant_assembly.yml
```

This will create a conda environment called `vikrant_assembly` that can be activated by the command:

```
conda activate vikrant_assembly
```

These environments are automatically activated in the job scripts when necessary, so no need to activate them yourself.

## Job scripts

All job scripts are contained in the `scripts/` directory.

To submit a job, run the command `sbatch scripts/run_{job}.sh` and it will be submitted to the cluster.

The stdout and stderr output of each script will be written to files in the `slurm/` directory to keep everything tidy.

## Running order

### Basecalling

`run_dorado.sh`

The first task is to basecall the raw nanopore data into `fastq` reads.
You'll be using dorado for this, previously we used guppy but that is being phased out in favour of dorado which makes use of the more efficient `POD5` raw data format.
To carry out basecalling, submit `sbatch scripts/run_dorado.sh`.
This will take the raw read data stored in the project folder, basecall it, and output the basecalled reads to `reads.fastq.gz`

### Assembly

`run_flye.sh`

Assembly is conducted with flye which achieved the best results from testing.

### Scaffolding

`run_ragtag.sh`

Scaffolding is conducted with ragtag.
You'll need to download `DM_1-3_516_R44_potato_genome_assembly.v6.1.fa.gz` and place it in the base directory before starting.
