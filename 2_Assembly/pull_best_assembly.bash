#!/bin/bash


mkdir -p best_assembly

# Loop over each kmer output directory
for dir in */; do
    # Extract the kmer value from the directory name (assuming it's the last part of the directory name)
    kmer_value=$(basename "$dir")

    # Find the assembly files and sort them numerically
    highest_file=$(ls "$dir"/*-[0-9]*.fa 2>/dev/null | sort -V | tail -n 1)

    # Check if a file was found
    if [ -n "$highest_file" ]; then
        # Get the base name of the highest file (without the path)
        base_name=$(basename "$highest_file")
        
        # Create a new name with the kmer value
        new_name="best_${kmer_value}_${base_name}"

        # Move and rename the file to the best_assembly directory
        mv "$highest_file" "best_assembly/$new_name"
    fi
done
