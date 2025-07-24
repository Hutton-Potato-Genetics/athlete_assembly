#!/bin/bash

#SBATCH -p long
#SBATCH -c 32
#SBATCH --mem=32G
#SBATCH --export=ALL
#SBATCH -o logs/braker3.%j.out
#SBATCH -e logs/braker3.%j.err

ASSEMBLY_FILE="results/assembly/final/final_assembly.fa.new.masked"
MERGED_BAM="results/star/merged.bam"

singularity exec -B /mnt/:/mnt/ docker://teambraker/braker3:v3.0.7.5 braker.pl \
  --AUGUSTUS_CONFIG_PATH=$APPS/Augustus/config \
  --genome=${ASSEMBLY_FILE} \
  --bam=${MERGED_BAM} \
  --prot_seq=misc/Viridiplantae.fa \
  --softmasking \
  --threads 32 \
  --workingdir=results/braker \
  --gff

