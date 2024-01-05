#!/bin/bash

#SBATCH -J flye
#SBATCH -p long
#SBATCH -c 32
#SBATCH --mem=256G
#SBATCH --export=ALL
#SBATCH -o slurm/flye.%j.out
#SBATCH -e slurm/flye.%j.err

source activate vikrant_assembly

cp reads.fastq.gz $TMPDIR

flye --threads 32 --nano-hq $TMPDIR/reads.fastq.gz --out-dir flye