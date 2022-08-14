#!/bin/bash -l
#SBATCH -D /scratch/twinkle1/repeatmodeler/
#SBATCH -t 200:00:00
#SBATCH -J rmodeler
#SBATCH -o /home/twinkle1/master_thesis/logs/repeatmodeler/mappingLog-%j.txt
#SBATCH --error /home/twinkle1/master_thesis/logs/repeatmodeler/errorLog-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=42gb
#SBATCH --mail-user=twinkle1@smail.uni-koeln.de
#SBATCH --mail-type=ALL


# run on cheops1
# this script is used to run repeatmodeler on the newly polished reference assembly


# load modules
module load repeatmodeler/2.0.1

# create database directory
mkdir -p /scratch/twinkle1/repeatmodeler/database/

### Main
# increased number of tasks, each rmblast job will take 4 threads
# for 20 threads, the pa setting while using rmblast should be 5

# Create database
BuildDatabase -name /scratch/twinkle1/repeatmodeler/database/polished \
	#/home/twinkle1/reference_genomes/polished/Ahypochondriacus_2.2_polished.fasta
	/home/twinkle1/projects/A_hypochondriacus_reannotation/data/NextPolish/processed/Ahypochondriacus_2.2_polished.fasta

# run Repeatmodeler
RepeatModeler -database /scratch/twinkle1/repeatmodeler/database/polished \
	-pa 5 \
	-LTRStruct #\
	#-recoverDir /scratch/twinkle1/repeatmodeler/RM_22013.FriApr81710362022/
