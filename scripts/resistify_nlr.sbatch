#!/bin/bash

#SBATCH -p short
#SBATCH -c 32
#SBATCH --mem=64gb
#SBATCH --export=all
#SBATCH -o logs/resistify_nlr.%j.out
#SBATCH -e logs/resistify_nlr.%j.out

mkdir -p results/resistify

source activate resistify

resistify nlr \
  --coconat \
  -o results/resistify/nlr_helixer \
  results/helixer/helixer.pep.fa
