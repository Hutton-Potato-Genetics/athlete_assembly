#!/bin/bash

#SBATCH -p medium
#SBATCH -c 16
#SBATCH --mem=32gb
#SBATCH --export=all
#SBATCH -o logs/methylation.%j.out
#SBATCH -e logs/methylation.%j.out

mkdir -p results/methylation

source activate modkit
DORADO=$APPS/dorado-1.0.2-linux-x64/bin/dorado
ASSEMBLY=results/ragtag/phased_primary.fa


$DORADO aligner --mm2-opts "-Y" $ASSEMBLY \
  results/dorado_new/reads.bam \
  | samtools sort -@ 16 - > results/methylation/aligned.full.bam

samtools index results/methylation/aligned.full.bam

# samtools index results/methylation/aligned.bam

# modkit pileup results/methylation/aligned.bam \
#   --ref $ASSEMBLY \
#   --motif CG 0 \
#   --ignore h

# modkit pileup results/methylation/aligned.bam \
#   --ref $ASSEMBLY \
#   --motif CHG 0 \
#   --ignore h

# modkit pileup results/methylation/aligned.bam \
#   --ref $ASSEMBLY \
#   --motif CHH 0 \
#   --ignore h

