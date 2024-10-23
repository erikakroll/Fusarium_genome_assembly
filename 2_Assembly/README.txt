

abyss.sbatch assembles genome using abyss, while generating output directories for specified kmer values.

pull_best_assembly.bash should be run directly in bash within the directory containing all kmer output directories. This script will pull the final assembly
output from abyss and move them into one folder, while also specifying strain name. 

BUSCO.sbatch and QUAST.sbatch should be run in best_assembly directory. This will assess all strains in the directory. 
