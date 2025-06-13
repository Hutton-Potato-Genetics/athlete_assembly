#!/bin/bash

#SBATCH -p short
#SBATCH -c 4
#SBATCH --mem=8G
#SBATCH --export=ALL
#SBATCH -o logs/map_candidates.%j.out
#SBATCH -e logs/map_candidates.%j.out

mkdir -p results/candidates

GENOME=$(realpath results/ragtag/phased_primary.fa)
CANDIDATES=/mnt/shared/scratch/ycheung/NextFlow_RGene/20240917_H1/Publication/Buster/Ag_results_Higher_Threshold/candidates.fa
  
source activate vikrant_assembly

minimap2 -ax asm5 $GENOME $CANDIDATES > results/candidates/mapped.sam

