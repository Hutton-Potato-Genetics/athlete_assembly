#!/bin/env -S pixi exec -s resistify==1.2.0 -- bash

#SBATCH -p short
#SBATCH -c 32
#SBATCH --mem 64gb
#SBATCH --export all
#SBATCH -o logs/resistify.%j.out
#SBATCH -e logs/resistify.%j.out

OUT_DIR=results/resistify

resistify nlr \
  --coconat \
  -o $OUT_DIR \
  results/helixer/helixer.pep.fa
