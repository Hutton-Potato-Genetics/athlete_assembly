#!/bin/bash

#SBATCH -J kmc
#SBATCH -p short
#SBATCH -c 32
#SBATCH --mem=64G
#SBATCH --export=ALL
#SBATCH -o slurm/kmc.%j.out
#SBATCH -e slurm/kmc.%j.err

source activate vikrant_assembly

mkdir $TMPDIR/kmc
cd $TMPDIR/kmc

kmc -k21 -t32 -m64 -ci1 -cs10000 $TBC kmc/reads $TMPDIR
kmc_tools transform kmc/reads.histo histogram kmc/reads.histo -cx10000
genomescope2 -i kmc/reads.histo -o genomescope2 -k 21

cd -
cp -r $TMPDIR/genomescope2 ./