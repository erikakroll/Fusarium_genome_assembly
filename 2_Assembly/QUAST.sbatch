#!/bin/bash
#SBATCH --job-name=Quast      # Job name
#SBATCH --partition=standard             # Specify the partition/queue
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks=1                      # Total number of tasks
#SBATCH --cpus-per-task=1              # Number of CPU cores per task
#SBATCH --mem=16G                       # Total memory per node
#SBATCH --time=2-00:00:00                 # Time limit (2 d)
#SBATCH --output=logs/quast_%A_%a.out   # Standard output
#SBATCH --error=logs/quast_%A_%a.err    # Standard error
#SBATCH --qos=medium
###############################################################################

module load apptainer

apptainer exec /home/data/hpc_resources/sif_files/quast/quast_5.2.0.sif quast.py *.fa -o  quast_results/"${assembly%.fa}_quast_results" --fungus 


