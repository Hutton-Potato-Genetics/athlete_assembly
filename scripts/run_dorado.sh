#!/bin/bash

#SBATCH -J dorado
#SBATCH -p gpu
#SBATCH -c 8
#SBATCH --mem 16G
#SBATCH --gpus=2
#SBATCH -o slurm/dorado.%j.out
#SBATCH -e slurm/dorado.%j.err

dorado_path="/mnt/shared/scratch/msmith/apps/dorado-0.3.4-linux-x64/bin/dorado"
model="/mnt/shared/scratch/msmith/apps/dorado-0.3.4-linux-x64/models/dna_r10.4.1_e8.2_400bps_sup@v4.2.0"
read_path="/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT"

cp -r $read_path/legacy_pod5 $TMPDIR
cp -r $read_path/dihaploid_2023-07-19 $TMPDIR
cp -r $read_path/dihaploid_2023-07-21 $TMPDIR

$dorado_path basecaller --emit-fastq -r $model $TMPDIR > $TMPDIR/duplex.fastq

gzip -f $TMPDIR/duplex.fastq > duplex.fastq.gz