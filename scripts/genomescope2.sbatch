#!/bin/env -S pixi exec -s kmc==3.2.4 -s genomescope2==2.0.1 -- bash

#SBATCH -p short
#SBATCH -c 8
#SBATCH --mem=64G
#SBATCH --export=ALL
#SBATCH -o logs/genomescope2.%j.log
#SBATCH -e logs/genomescope2.%j.log

OUT_DIR=./results/genomescope2

READS=./results/dorado/reads.fq.gz

mkdir -p $OUT_DIR

K=21

kmc -k$K -t$SLURM_CPUS_PER_TASK -m64 -ci1 -cs10000 $READS $TMPDIR/reads $TMPDIR

kmc_tools transform $TMPDIR/reads histogram $TMPDIR/reads.histo -cx10000

genomescope2 -i $TMPDIR/reads.histo -o $OUT_DIR -k $K
