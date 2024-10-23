#!/bin/bash
#################################################
# Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk 
#SBATCH --mail-type=ALL
#SBATCH --partition=standard 
#SBATCH --time=0-03:00
#SBATCH --qos=medium
# Job name 
#SBATCH --job-name=Trimmomatic
# Job stdout file
#SBATCH --output=Trimmomatic.out.%J
# Job stderr file
#SBATCH --error=Trimmomatic.err.%J 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=80000  # Adjust based on your memory needs
#################################

# Load the Trimmomatic module if needed
module load Trimmomatic/0.39-Java-11

# Define the number of threads to use for Trimmomatic
THREADS=8

# Loop over each strain directory
for STRAIN_DIR in */; do
    # Remove trailing slash to get the strain name
    STRAIN=$(basename "${STRAIN_DIR}")

    # Find input files using wildcard matching
    READ1=$(ls "${STRAIN_DIR}"/*_R1.fastq.gz)
    READ2=$(ls "${STRAIN_DIR}"/*_R2.fastq.gz)

    # Define output file names for trimmed paired and unpaired reads
    TRIMMED_READ1_PAIRED="${STRAIN_DIR}/${STRAIN}_R1_trimmedpaired.fastq.gz"
    TRIMMED_READ2_PAIRED="${STRAIN_DIR}/${STRAIN}_R2_trimmedpaired.fastq.gz"

    # Run Trimmomatic on the paired-end 
	java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE \
        -threads $THREADS \
        -trimlog "${STRAIN_DIR}/${STRAIN}-trimmomatic.log" \
        "$READ1" "$READ2" \
        "$TRIMMED_READ1_PAIRED" \
        "$TRIMMED_READ2_PAIRED" \
        ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
	
   
