# Dihaploid analysis

This repository contains all the code used to carry out the dihaploid genome assembly and analysis.

To download this repository, simply run the code:

```
git clone https://github.com/SwiftSeal/vikrant_assembly.git
```

This will download the code to your current repository, ideally keep it in your scratch directory.

## Conda environments

The primary conda environment used in this analysis is stored under the `environments/` directory.
To install a conda environment, run the following code:

```
conda env create -f environments/vikrant_assembly.yml
```

This will create a conda environment called `vikrant_assembly` that can be activated by the command:

```
conda activate vikrant_assembly
```

This environment contains dependencies that are mostly used to handle intermediate data.

## Job scripts

All job scripts are contained in the `scripts/` directory.

To submit a job, run the command `sbatch scripts/...` and it will be submitted to the cluster.

The stdout and stderr output of each script will be written to files in the `logs/` directory to keep everything tidy.

## Running order

### Basecalling

`dorado.sbatch`

This script submits an array job that runs dorado on all available ONT runs for this genome.
They will be written under the `results/dorado` directory as BAM files which also contain DNA methylation data.

The legacy reads are only compatible with 4.1.0 model due to their older sampling rate.
To basecall these, it's:

```
$APPS/dorado-0.9.6-linux-x64/bin/dorado basecaller \
  -r \
  --modified-bases-models $APPS/dorado-0.9.6-linux-x64/models/dna_r10.4.1_e8.2_400bps_sup@v4.1.0_5mCG_5hmCG@v2 \
  $APPS/dorado-0.9.6-linux-x64/models/dna_r10.4.1_e8.2_400bps_sup@v4.1.0 \
  /mnt/shared/projects/jhi/potato/202302_dihaploid-ONT/legacy_pod5/ > results/dorado/reads2.bam
```

These are then merged into a single BAM file and FASTQ file with the `dorado_merge.sbatch` script.

After basecalling, you can then run:

```
cramino --hist --ubam results/dorado/merged.bam > results/dorado/read_stats.txt
````

And this will produce some useful statistics on the merged reads.

### Assembly

The primary and scaffolded genome assembly is produced with the `nf_genomeassembler.sbatch` script.
This uses the nf-core genomeassembler pipeline, which is sufficient for our purposes.
It also produces some handy QC stuff - yey.

It needs the DM genome to be downloaded and placed under `results/dm`.
This is pointed to in the `data/genomeassembler_samplesheet.csv` file, which is used by this command.

