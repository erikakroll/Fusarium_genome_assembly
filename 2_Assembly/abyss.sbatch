#!/bin/bash
#SBATCH --job-name=abyss_kmer_test      # Job name
#SBATCH --partition=standard             # Specify the partition/queue
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks=1                      # Total number of tasks
#SBATCH --cpus-per-task=1              # Number of CPU cores per task
#SBATCH --mem=16G                       # Total memory per node
#SBATCH --time=2-00:00:00                 # Time limit (2 d)
#SBATCH --array=61-99                 # K-mer sizes to test
#SBATCH --output=logs/abyss_%A_%a.out   # Standard output
#SBATCH --error=logs/abyss_%A_%a.err    # Standard error
#SBATCH --qos=medium



######## load conda env
module load Miniconda3

source activate abyss



# Define the base directory (change to the absolute path of your working directory)
BASE_DIR="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Fgraminearum_strains_for_Pangenome_analysis/1st_batch"

# Loop over each strain directory
for STRAIN_DIR in "${BASE_DIR}"/*/; do

    # Remove trailing slash to get the strain name
    STRAIN=$(basename "${STRAIN_DIR}")
    
    # Define the input files with absolute paths
    READ1=$(ls "${STRAIN_DIR}"/*_R1.fastq.gz)
    READ2=$(ls "${STRAIN_DIR}"/*_R2.fastq.gz)
    
    # Check if both read files exist
        # Create output directory for this strain and k-mer size
        OUTPUT_DIR="${STRAIN_DIR}/abyss/fusout${STRAIN}/k${SLURM_ARRAY_TASK_ID}"
        mkdir -p "${OUTPUT_DIR}"
        
        # Run ABySS with the specified k-mer size
        abyss-pe -C "${OUTPUT_DIR}" \
            name=fusotu${STRAIN} \
            k=${SLURM_ARRAY_TASK_ID} \
            in="'${READ1}' '${READ2}'" \
            np=1
done