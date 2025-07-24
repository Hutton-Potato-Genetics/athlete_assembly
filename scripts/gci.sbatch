#!/bin/bash

#SBATCH -p himem
#SBATCH -c 32
#SBATCH --mem=84gb
#SBATCH --export=ALL
#SBATCH -o logs/gci.%j.out
#SBATCH -e logs/gci.%j.out

ASSEMBLY=results/ragtag/phased_primary.fa
READS=results/dorado/merged.fq.gz
HAPLOTYPE=B

seqkit grep -r -p "_$HAPLOTYPE" $ASSEMBLY > $TMPDIR/$HAPLOTYPE.fa

ASSEMBLY=$TMPDIR/$HAPLOTYPE.fa

source activate gci

mkdir -p results/gci

minimap2 -t $SLURM_CPUS_PER_TASK -ax map-ont $ASSEMBLY $READS | \
  samtools sort -@ $SLURM_CPUS_PER_TASK -o $TMPDIR/ont.minimap2.sorted.bam

samtools index $TMPDIR/ont.minimap2.sorted.bam

meryl count k=15 output $TMPDIR/meryl.db $ASSEMBLY
meryl print greater-than distinct=0.9998 $TMPDIR/meryl.db > $TMPDIR/meryl_repetitive_k15.txt

winnowmap -t $SLURM_CPUS_PER_TASK -W $TMPDIR/meryl_repetitive_k15.txt -ax map-ont $ASSEMBLY $READS | \
  samtools view -b - | \
  samtools sort -@ $SLURM_CPUS_PER_TASK -o $TMPDIR/ont.winnowmap.sorted.bam

samtools index $TMPDIR/ont.winnowmap.sorted.bam
  
GCI \
  -r $ASSEMBLY \
  --nano $TMPDIR/ont.winnowmap.sorted.bam $TMPDIR/ont.minimap2.sorted.bam \
  -d results/gci/hap$HAPLOTYPE \
  -t $SLURM_CPUS_PER_TASK \
  -p
  
