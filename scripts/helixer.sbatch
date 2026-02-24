#!/bin/env -S pixi exec -s gffread==0.12.7 -- bash

#SBATCH -p gpu
#SBATCH -c 8
#SBATCH --mem=64gb
#SBATCH --gpus=1
#SBATCH --export=ALL
#SBATCH -o logs/helixer.%j.out
#SBATCH -e logs/helixer.%j.out

ASSEMBLY=results/assembly/phased_primary.fa
OUT_DIR=results/helixer

singularity exec --nv -B /mnt/:/mnt/ $APPS/helixer-docker_helixer_v0.3.4_cuda_12.2.2-cudnn8.sif \
  Helixer.py \
  --species athlete \
  --fasta-path $ASSEMBLY \
  --gff-output-path $OUT_DIR/helixer.gff \
  --model-filepath "$APPS/land_plant_v0.3_a_0080.h5" \
  --subsequence-length 64152

gffread \
  -g $ASSEMBLY \
  -S \
  -y $OUT_DIR/helixer.pep.fa \
  -x $OUT_DIR/helixer.cds.fa \
  $OUT_DIR/helixer.gff

