[![DOI](https://zenodo.org/badge/1025679742.svg)](https://doi.org/10.5281/zenodo.16418964)

# Dihaploid analysis

This repository contains all the code used to carry out the dihaploid genome assembly and analysis.

To download this repository, simply run the code:

```
git clone https://github.com/Hutton-Potato-Genetics/athlete_assembly.git
```

This will download the code to your current repository, ideally keep it in your scratch directory.

## Dependencies

Dependencies are handled through a combination of singularity containers of `pixi` environments that will be automatically initiated upon script submission.
You'll need a working version of `pixi` for this to work.

## Job scripts

All job scripts are contained in the `scripts/` directory.

To submit a job, run the command `sbatch scripts/...` and it will be submitted to the cluster.

The stdout and stderr output of each script will be written to files in the `logs/` directory to keep everything tidy.

## Running order

1. Basecalling
   1. `scripts/dorado.sbatch` - writes merged BAM and FASTQ file to `./results/dorado`. Saves move table for enhanced polishing of assembly.
2. Genome size estimation
   1. `scripts/genomescope2.sbatch` - uses `genomescope2` and 21-mers from basecalled reads for genome size estimation.
3. Assembly
   1. `scripts/hifiasm.sbatch` - produces unscaffolded haplotigs.
   2. `scripts/ragtag.sbatch` - for each set of haplotigs, scaffold to reference. THIS IS NOT "FULLY PHASED". It is an array job, using an array of 1-2 to represent the two haplotypes.
   3. `scripts/merge_haplotypes.py` - Merges the two chromosomal scaffolds of each haplotype into a single assembly.
4. Annotation
   1. `scripts/helixer.sbatch` - Predicts genes with Helixer
   2. `scripts/hite.sbatch` - Predicts high-confidence TEs with HiTE. Needs a container or a conda environment - check their github for latest instructions.
   3. `scripts/resistify.sbatch` - Predicts NLR from Helixer-derived protein sequences.
5. QC
   1. `scripts/gci.sbatch` - Uses read coverage to estimate genome assembly quality. Read GCI paper for more info.