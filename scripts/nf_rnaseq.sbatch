#!/bin/bash

#SBATCH -p long
#SBATCH -c 1
#SBATCH --mem=8gb
#SBATCH --export=all
#SBATCH -o logs/nf-rnaseq.%j.out
#SBATCH -e logs/nf-rnaseq.%j.out

nextflow run nf-core/rnaseq \
    -r 3.19.0 \
    --input data/rnaseq_samplesheet.csv \
    --outdir results/nf_rnaseq_annevo \
    --fasta results/ragtag/phased_primary.fa \
    --skip_biotype_qc \
    --gff results/annevo/annevo.gff
