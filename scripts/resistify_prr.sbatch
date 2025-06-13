#!/bin/bash

#SBATCH -p gpu
#SBATCH --gpus 1
#SBATCH -c 16
#SBATCH --mem=64gb
#SBATCH --export=all
#SBATCH -o logs/resistify_prr.%j.out
#SBATCH -e logs/resistify_prr.%j.out

mkdir -p results/resistify

source activate resistify

resistify prr \
  -o results/resistify/prr \
  results/annevo/phased_primary.gene.pep.fa
