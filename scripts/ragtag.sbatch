#!/bin/bash

#SBATCH -p short
#SBATCH -c 8
#SBATCH --mem=16G
#SBATCH --export=ALL
#SBATCH -o logs/ragtag.%j.out
#SBATCH -e logs/ragtag.%j.out

source activate vikrant_assembly

ASSEMBLY=results/hifiasm/assembly.
REFERENCE=results/dm/DM_1-3_516_R44_potato_genome_assembly.v6.1.fa.gz 

ragtag.py scaffold -t 8 -o results/ragtag $REFERENCE $ASSEMBLY
