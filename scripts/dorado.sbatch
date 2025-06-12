#!/bin/bash

#SBATCH -J dorado_array
#SBATCH -p gpu
#SBATCH -c 8
#SBATCH --mem 32G
#SBATCH --gpus-per-node=2
#SBATCH --array=0-4 # 5 tasks (0, 1, 2, 3, 4)
#SBATCH -o logs/dorado_array.%A_%a.out # %A for job ID, %a for array task ID
#SBATCH -e logs/dorado_array.%A_%a.err

dorado_path=$APPS/dorado-0.9.6-linux-x64/bin/dorado
read_path="/mnt/shared/projects/jhi/potato/202302_dihaploid-ONT"

mkdir -p results/dorado

# Define an array of input directories
input_dirs=(
    "/mnt/shared/projects/jhi/misc/miseq/PromethION/20250128_P2i_00059_18_PBA21483/Athlete_DH_Vikrant"
    "$read_path/legacy_pod5"
    "$read_path/dihaploid_2023-07-19"
    "$read_path/dihaploid_2023-07-21"
    "$read_path/athlete"
)

# Get the current task's input directory
current_input_dir="${input_dirs[$SLURM_ARRAY_TASK_ID]}"
output_file="results/dorado/reads$((SLURM_ARRAY_TASK_ID + 1)).bam"

$dorado_path basecaller -r sup,5mC_5hmC "$current_input_dir" > "$output_file"

