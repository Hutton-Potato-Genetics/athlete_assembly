#!/bin/bash

#SBATCH -J duplex
#SBATCH -p gpu
#SBATCH -c 8
#SBATCH --mem 16G
#SBATCH --gpus=2
#SBATCH -o slurm/duplex.%j.out
#SBATCH -e slurm/duplex.%j.err

dorado_path="/mnt/shared/scratch/msmith/apps/dorado-0.3.4-linux-x64/bin/dorado"
model="dna_r10.4.1_e8.2_400bps_sup@v4.2.0"
read_path="/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT"

$dorado_path basecaller -r $model $read_path > $TMPDIR/reads.fastq

gzip -f $TMPDIR/reads.fastq > reads.fastq.gz