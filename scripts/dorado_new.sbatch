#!/bin/bash

#SBATCH -p gpu
#SBATCH -c 8
#SBATCH --mem 32G
#SBATCH --gpus-per-node=2
#SBATCH -o logs/dorado.%j.out
#SBATCH -e logs/dorado.%j.out

dorado_path=$APPS/dorado-1.0.2-linux-x64/bin/dorado
read_path="/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT"

mkdir -p results/dorado_new

READS="/mnt/shared/projects/jhi/misc/miseq/PromethION/20250128_P2i_00059_18_PBA21483/Athlete_DH_Vikrant"

$dorado_path basecaller -r sup,5mC_5hmC $READS > results/dorado_new/reads.bam
