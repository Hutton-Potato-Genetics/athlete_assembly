#!/bin/bash

#SBATCH -p gpu
#SBATCH -c 8
#SBATCH --mem=64gb
#SBATCH --gpus=1
#SBATCH --export=ALL
#SBATCH -o logs/helixer.%j.out
#SBATCH -e logs/helixer.%j.out

mkdir -p results/helixer

ASSEMBLY=results/ragtag/phased_primary.fa

singularity exec --nv -B /mnt/:/mnt/ $APPS/helixer-docker_helixer_v0.3.4_cuda_12.2.2-cudnn8.sif \
  Helixer.py \
  --species athlete \
  --fasta-path $ASSEMBLY \
  --gff-output-path results/helixer/helixer.gff \
  --model-filepath "$APPS/land_plant_v0.3_a_0080.h5" \
  --subsequence-length 64152

gffread \
  -g $ASSEMBLY \
  -S -y results/helixer/helixer.faa \
  results/helixer/helixer.gff

