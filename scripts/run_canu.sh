#!/bin/bash

#SBATCH -J canu
#SBATCH -p short
#SBATCH -c 1
#SBATCH --mem=4G
#SBATCH --export=ALL
#SBATCH -o slurm/canu.%j.out
#SBATCH -e slurm/canu.%j.err

source activate vikrant_assembly

canu -nanopore $TBC \
genomeSize=700m \
gridOptions="--partition=long" \
cnsMemory=10 -p dihaploid \
-d canu