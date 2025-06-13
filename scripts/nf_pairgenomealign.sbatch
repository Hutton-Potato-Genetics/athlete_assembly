#!/bin/bash

#SBATCH -p long
#SBATCH -c 1
#SBATCH --mem=8gb
#SBATCH --export=all
#SBATCH -o logs/nf-pairgenomealign.%j.out
#SBATCH -e logs/nf-pairgenomealign.%j.out

nextflow run nf-core/pairgenomealign \
    -r 2.1.0 \
    -resume \
    --input data/pairgenomealign_samplesheet.csv \
    --target results/dm/DM_1-3_516_R44_potato_genome_assembly.v6.1.primary.fa \
    --outdir results/nf-pairgenomealign
