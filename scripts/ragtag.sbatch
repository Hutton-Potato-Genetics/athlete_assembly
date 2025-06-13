#!/bin/bash

#SBATCH -p short
#SBATCH -c 8
#SBATCH --mem=32G
#SBATCH --export=ALL
#SBATCH -o logs/ragtag.%A_%a.out
#SBATCH -e logs/ragtag.%A_%a.out
#SBATCH --array=1-2

mkdir -p results/ragtag

source activate vikrant_assembly

REFERENCE=results/dm/DM_1-3_516_R44_potato_genome_assembly.v6.1.primary.fa

ASSEMBLY=results/hifiasm/assembly.bp.hap$SLURM_ARRAY_TASK_ID.p_ctg.fa
OUTDIR=results/ragtag/hap$SLURM_ARRAY_TASK_ID

ragtag.py scaffold -w -t 8 -o $OUTDIR $REFERENCE $ASSEMBLY
