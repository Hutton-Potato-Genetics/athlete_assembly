#!/bin/bash

#SBATCH -J kmc
#SBATCH -p short
#SBATCH -c 32
#SBATCH --mem=64G
#SBATCH --export=ALL
#SBATCH -o logs/kmc.%j.out
#SBATCH -e logs/kmc.%j.out

READS=results/dorado/merged.fq.gz

mkdir -p results/kmc

source activate vikrant_assembly

kmc -k21 -t32 -m64 -ci1 -cs10000 $READS $TMPDIR/reads $TMPDIR
kmc_tools transform $TMPDIR/reads histogram results/kmc/reads.histo -cx10000
genomescope2 -i results/kmc/reads.histo -o genomescope2 -k 21

cd -
cp -r $TMPDIR/genomescope2 ./
