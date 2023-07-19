#!/bin/bash

#SBATCH -J guppy_basecall
#SBATCH -p gpu
#SBATCH -c 16
#SBATCH --mem 16G
#SBATCH --gpus=2
#SBATCH -o slurm/guppy_basecall_%j.out
#SBATCH -e slurm/guppy_basecall_%j.err

input_path="/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT"
save_path="e82_sup"
prefix="dihaploid"

mkdir $TMPDIR/fastq

/mnt/shared/scratch/msmith/apps/ont-guppy/bin/guppy_basecaller -c dna_r10.4.1_e8.2_400bps_sup.cfg --recursive --input_path $input_path --save_path $save_path/fastq -x 'auto' --compress_fastq

zcat $save_path/fastq/pass/* > $save_path/"$prefix".fastq

gzip -f $save_path/"$prefix".fastq
