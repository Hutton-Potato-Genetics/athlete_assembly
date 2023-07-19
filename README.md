# Dihaploid analysis

This repository contains all the code used to carry out the dihaploid genome assembly and analysis.

To download this repository, simply run the code:

```
git clone https://github.com/SwiftSeal/vikrant_assembly.git
```

This will download the code to your current repository, ideally keep it in your scratch directory.

## Conda environments

The conda environment recipes used in this analysis are stored under the `environments/` directory.
To install a conda environment, run the following code:

```
conda env create -f environments/vikrant_assembly.yml
```

This will create a conda environment called `vikrant_assembly` that can be activated by the command:

```
conda activate vikrant_assembly
```

These environments are automatically activated in the job scripts, so no need to activate them yourself.

## Job scripts

All job scripts are contained in the `scripts/` directory.

To submit a job, run the command `sbatch scripts/run_canu.sh` and it will be submitted to the cluster.

The stdout and stderr output of each script will be written to files in the `slurm/` directory to keep everything tidy.
