#!/bin/bash
#SBATCH --job-name=BUSCO         # Job name
#SBATCH --partition=standard     # Specify the partition/queue
#SBATCH --nodes=1                # Number of nodes
#SBATCH --ntasks=1               # Total number of tasks
#SBATCH --cpus-per-task=4        # Number of CPU cores per task 
#SBATCH --mem=16G                # Total memory per node
#SBATCH --time=2-00:00:00        # Time limit (2 days)
#SBATCH --output=logs/busco_%A_%a.out   # Standard output
#SBATCH --error=logs/busco_%A_%a.err    # Standard error
#SBATCH --qos=medium
###############################################################################

# Load apptainer
module load apptainer

# Loop over each .fa file in the specified directory
for assembly_file in *.fa; do
    # Extract the base name of the file (without path and extension)
    strain_file=$(basename "${assembly_file}" .fa)

    # Define the output directory for each strain (removed extra space)
    out_dir="busco/${strain_file}"

    # Create the output directory if it doesn't exist
    mkdir -p "${out_dir}"

    # Run BUSCO
    apptainer exec /home/data/hpc_resources/sif_files/busco/busco_5.7.1.sif busco \
          -i "${assembly_file}" \
          -m genome \
          -o abyss_assm_${strain_file}_busco \
          -l hypocreales_odb10 \
          --out_path "${out_dir}" \
          -c ${SLURM_CPUS_PER_TASK} -f \
		  --offline --download_path ../busco_database/v5/data/
done
