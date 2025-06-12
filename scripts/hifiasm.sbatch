#!/bin/bash

#SBATCH -p short
#SBATCH -c 32
#SBATCH --mem=128gb
#SBATCH --export=all
#SBATCH -o logs/hifiasm.%j.out
#SBATCH -e logs/hifiasm.%j.out

mkdir -p results/hifiasm

source activate vikrant_assembly

hifiasm --primary --ont results/dorado/merged.fq.gz -t 32 -o results/hifiasm/assembly

