#!/bin/bash

#SBATCH -J ragtag
#SBATCH -p short
#SBATCH -c 4
#SBATCH --mem=16G
#SBATCH --export=ALL
#SBATCH -o slurm/ragtag.%j.out
#SBATCH -e slurm/ragtag.%j.err

source activate vikrant_assembly

ragtag.py scaffold -t 4 -o ragtag DM_1-3_516_R44_potato_genome_assembly.v6.1.fa.gz canurun/dihaploid.contigs.fasta