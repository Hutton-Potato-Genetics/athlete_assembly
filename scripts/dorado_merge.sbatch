#!/bin/bash

#SBATCH -p short
#SBATCH -c 8
#SBATCH --mem 8G
#SBATCH -o logs/dorado-merge.out
#SBATCH -e logs/dorado-merge.out

samtools merge -@ 8 -f -o results/dorado/merged.bam results/dorado/reads*
samtools bam2fq results/dorado/merged.bam | pigz > results/dorado/merged.fq.gz
