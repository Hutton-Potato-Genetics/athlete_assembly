#!/bin/bash

#SBATCH -p gpu
#SBATCH --gpus-per-node a100:4
#SBATCH -c 8
#SBATCH --mem 32gb
#SBATCH --export all
#SBATCH -o logs/dorado.%j.out
#SBATCH -e logs/dorado.%j.out

export PATH="$APPS/dorado-1.3.1-linux-x64/bin:$PATH"

POD5_DIRS=(
    "/mnt/shared/projects/jhi/misc/miseq/PromethION/20250128_P2i_00059_18_PBA21483/Athlete_DH_Vikrant"
    "/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT/legacy_pod5"
    "/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT/dihaploid_2023-07-19"
    "/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT/dihaploid_2023-07-21"
    "/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT/athlete"
)

OUT_DIR="./results/dorado"

mkdir -p "$OUT_DIR"

for POD5_DIR in "${POD5_DIRS[@]}"; do
  dorado basecaller --emit-moves -r sup,5mC_5hmC "$POD5_DIR" > "$TMPDIR/$(basename $POD5_DIR).bam"
done

samtools cat -o "$OUT_DIR/reads.bam" "$TMPDIR"/*.bam

samtools fastq -@ $SLURM_CPUS_PER_TASK "$OUT_DIR/reads.bam" | \
  pigz > "$OUT_DIR/reads.fq.gz"

