#!/bin/bash
#SBATCH -p academic
#SBATCH --job-name=hannaZ		# Job name
#SBATCH --mail-type=NONE		# Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --cpus-per-task=1		# Number of CPU cores per task
#SBATCH --mem=1GB				# Memory
#SBATCH --time=01:00:00			# Time limit hrs:min:sec
#SBATCH --output=output_%j.log	# Standard output and error log
#SBATCH --error=error_%j.log	# Error output
#SBATCH --output=NONE			# Standard output and error log
#SBATCH --error=NONE			# Error output
#SBATCH --array=1-10

module load R/4.1.0-fasrc01
Rscript start.r $SLURM_ARRAY_TASK_ID
