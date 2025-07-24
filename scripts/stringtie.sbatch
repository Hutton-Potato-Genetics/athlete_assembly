#!/bin/bash

#SBATCH -p short
#SBATCH -c 2
#SBATCH --mem=8G
#SBATCH --export=ALL
#SBATCH -o logs/stringtie.%j.out
#SBATCH -e logs/stringtie.%j.out

mkdir -p results/stringtie

source activate stringtie

stringtie -N -p 2 -o results/stringtie/stringtie3.noref.gtf results/stringtie/merged.bam
