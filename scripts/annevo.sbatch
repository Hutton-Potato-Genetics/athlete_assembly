#!/bin/bash

#SBATCH -p gpu
#SBATCH --gpus 1
#SBATCH -c 16
#SBATCH --mem=128G
#SBATCH --export=ALL
#SBATCH -o logs/annevo.%j.out
#SBATCH -e logs/annevo.%j.out

mkdir -p results/annevo

GENOME=$(realpath results/ragtag/phased_primary.fa)
OUTDIR=$(realpath results/annevo)

# ANNEVO is a PITA to install, so using it's own conda environment
source activate annevo

cd $APPS/ANNEVO

python annotation.py \
  --genome $GENOME \
  --lineage Embryophyta \
  --output $OUTDIR/phased_primary.gene.gff
  
