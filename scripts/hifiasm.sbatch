#!/bin/env -S pixi exec -s hifiasm==0.25.0 -- bash

#SBATCH -p short
#SBATCH -c 32
#SBATCH --mem 128gb
#SBATCH --export all
#SBATCH -o logs/hifiasm.%j.out
#SBATCH -e logs/hifiasm.%j.out

mkdir -p results/hifiasm

source activate vikrant_assembly

READS=./results/dorado/reads.fq.gz
OUTDIR=./results/hifiasm

hifiasm --write-ec --ont $READS -t $SLURM_CPUS_PER_TASK -o $OUTDIR/asm

awk '/^S/{print ">"$2;print $3}' $OUTDIR/asm.bp.hap1.p_ctg.gfa > $OUTDIR/asm.bp.hap1.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/asm.bp.hap2.p_ctg.gfa > $OUTDIR/asm.bp.hap2.p_ctg.fa

