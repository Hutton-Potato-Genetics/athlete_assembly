#!/bin/bash

#SBATCH -p himem
#SBATCH -c 1
#SBATCH --mem=32G
#SBATCH --export=ALL
#SBATCH -o logs/augustus.%j.out
#SBATCH -e logs/augustus.%j.out

GENOME=$(realpath results/ragtag/phased_primary.fa)

mkdir -p results/augustus

source activate augustus
  
augustus --species=tomato $GENOME > results/augustus/augustus.gff
  
