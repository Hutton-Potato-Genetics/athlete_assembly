#!/bin/bash

#SBATCH -p long
#SBATCH -c 64
#SBATCH --mem=128G
#SBATCH --export=ALL
#SBATCH -o logs/hite.%j.out
#SBATCH -e logs/hite.%j.out

GENOME=$(realpath results/ragtag/phased_primary.fa)
OUTDIR=$(realpath results/hite)
  
singularity exec -B /mnt/:/mnt/ $APPS/HiTE/HiTE.sif python /HiTE/main.py \
  --genome $GENOME \
  --annotate 1 \
  --thread 64 \
  --out_dir $OUTDIR
