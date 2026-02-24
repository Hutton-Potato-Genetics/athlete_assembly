#!/bin/env -S pixi exec -s ragtag==2.1.0 -- bash

#SBATCH --array 1-2
#SBATCH -p short
#SBATCH -c 8
#SBATCH --mem 32G
#SBATCH --export ALL
#SBATCH -o logs/ragtag.%j.out
#SBATCH -e logs/ragtag.%j.out

OUT_DIR=./results/ragtag/hap$SLURM_ARRAY_TASK_ID

mkdir -p $OUT_DIR

REFERENCE=./results/dm/DM_1-3_516_R44_potato_genome_assembly.v6.1.primary.fa

ASSEMBLY=results/hifiasm/assembly.bp.hap$SLURM_ARRAY_TASK_ID.p_ctg.fa

ragtag.py scaffold -w -t $SLURM_CPUS_PER_TASK -o $OUT_DIR $REFERENCE $ASSEMBLY
