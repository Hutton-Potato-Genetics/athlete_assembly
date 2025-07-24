#!/bin/bash

#SBATCH -p himem
#SBATCH -c 32
#SBATCH --mem=256G
#SBATCH --export=ALL
#SBATCH -o logs/earlgrey.%j.out
#SBATCH -e logs/earlgrey.%j.out

source activate earlgrey

earlGrey -g results/ragtag/phased_primary.fa -s athlete -o results/earlgrey -t 32
