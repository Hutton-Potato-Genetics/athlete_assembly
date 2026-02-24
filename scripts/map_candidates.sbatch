#!/bin/env -S pixi exec -s minimap2==2.30 -- bash

#SBATCH -p short
#SBATCH -c 4
#SBATCH --mem 8G
#SBATCH --export ALL
#SBATCH -o logs/map_candidates.%j.out
#SBATCH -e logs/map_candidates.%j.out

mkdir -p results/candidates

GENOME=$(realpath results/assembly/phased_primary.fa)
CANDIDATES=/mnt/shared/scratch/ycheung/NextFlow_RGene/20240917_H1/Publication/Buster/Ag_results_Higher_Threshold/candidates.fa

minimap2 -ax asm5 $GENOME $CANDIDATES > results/candidates/mapped.sam

