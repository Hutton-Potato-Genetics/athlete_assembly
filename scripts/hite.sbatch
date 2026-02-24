#!/bin/bash

#SBATCH -p long
#SBATCH -c 32
#SBATCH --mem 64G
#SBATCH --export ALL
#SBATCH -o logs/hite.%j.out
#SBATCH -e logs/hite.%j.out

GENOME=$(realpath results/assembly/phased_primary.fa)
OUT_DIR=$(realpath results/hite)
  
singularity exec -B /mnt/:/mnt/ $APPS/HiTE/HiTE.sif python /HiTE/main.py \
  --genome $GENOME \
  --annotate 1 \
  --thread $SLURM_CPUS_PER_TASK \
  --out_dir $OUT_DIR
