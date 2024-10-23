#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk 
#SBATCH --mail-type=ALL
#SBATCH --partition=standard 
#SBATCH --time=0-03:00
#SBATCH --qos=medium
#job name 
#SBATCH --job-name=FastQC
#job stdout file
#SBATCH --output=FastQC.out.%J
#job stderr file
#SBATCH --error=FastQC.err.%J 
#SBATCH --ntasks=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=80000
#############################################################


# Loop over each strain directory
for STRAIN_DIR in */; do
    # Remove trailing slash to get the strain name
    STRAIN=$(basename "${STRAIN_DIR}")

    # Find input files using wildcard matching
    READ1=$(ls "${STRAIN_DIR}"/*_R1.fastq.gz)
    READ2=$(ls "${STRAIN_DIR}"/*_R2.fastq.gz)
	
	module load FastQC/0.11.9-Java-11

	fastqc ${STRAIN}_R1_trimmedpaired.fastq.gz ${STRAIN}_R2_trimmedpaired.fastq.gz
	
done
