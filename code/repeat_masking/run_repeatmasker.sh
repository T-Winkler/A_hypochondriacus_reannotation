#!/bin/bash -l
#SBATCH -D /scratch/twinkle1/repeatmodeler/
#SBATCH -t 120:00:00
#SBATCH -J rmodeler
#SBATCH -o /home/twinkle1/master_thesis/logs/repeatmasker/mappingLog-%j.txt
#SBATCH --error /home/twinkle1/master_thesis/logs/repeatmasker/errorLog-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=42gb
#SBATCH --mail-user=twinkle1@smail.uni-koeln.de
#SBATCH --mail-type=ALL


# run on cheops1
# this script is used to run repeatmasker usuing the generated repeatmodeler repeatdatabase

# load modules
module load repeatmasker/4.1.1

# create database directory
mkdir -p /scratch/twinkle1/repeatmodeler/repeatmasking

### Main
# watch out with the processor setting, each rmblast job will take 4 threads
# for 20 threads, the pa setting while using rmblast should be 5

# Converted the polished reference genome fasta to all capital letters as preparation to repeatmasking:
awk '/^>/ {print($0)}; /^[^>]/ {print(toupper($0))}' /home/twinkle1/projects/A_hypochondriacus_reannotation/data/NextPolish/processed/Ahypochondriacus_2.2_polished.fasta \
	> /home/twinkle1/projects/A_hypochondriacus_reannotation/data/NextPolish/processed/Ahypochondriacus_2.2_polished.capital.fasta

### run RepeatMasker
# lib = repeat database created with repeatmodeler
RepeatMasker -lib /scratch/twinkle1/repeatmodeler/RM_22013.FriApr81710362022/consensi.fa.classified \
	-pa 5 \
	-small \
	-e rmblast \
	-gff \
	-dir /scratch/twinkle1/repeatmodeler/repeatmasking/ \
	/home/twinkle1/projects/A_hypochondriacus_reannotation/data/NextPolish/processed/Ahypochondriacus_2.2_polished.capital.fasta

# convert to softmasked fasta
module load bedtools/2.29.2
bedtools maskfasta \
	-fi /home/twinkle1/projects/A_hypochondriacus_reannotation/data/NextPolish/processed/Ahypochondriacus_2.2_polished.capital.fasta \
	-bed /scratch/twinkle1/repeatmodeler/repeatmasking/Ahypochondriacus_2.2_polished.capital.fasta.out.gff \
	-soft \
	-fo /home/twinkle1/projects/A_hypochondriacus_reannotation/data/repeatmasking/output/Ahypochondriacus_2.2_polished.softmasked.fasta

# copy selected files from repeatmodeler from /scratch/ partition and copy the softmasked file to the polished genome folder:
mkdir /home/twinkle1/projects/A_hypochondriacus_reannotation/data/repeatmasking/repeatmodeler/
cp /scratch/twinkle1/repeatmodeler/RM_22013.FriApr81710362022/consensi* /home/twinkle1/projects/A_hypochondriacus_reannotation/data/repeatmasking/repeatmodeler/
cp /scratch/twinkle1/repeatmodeler/RM_22013.FriApr81710362022/famil* /home/twinkle1/projects/A_hypochondriacus_reannotation/data/repeatmasking/repeatmodeler/

mkdir -p /home/twinkle1/projects/A_hypochondriacus_reannotation/polished_genome_annotation/assembly
cp /home/twinkle1/projects/A_hypochondriacus_reannotation/data/repeatmasking/output/Ahypochondriacus_2.2_polished.softmasked.fasta \
	/home/twinkle1/projects/A_hypochondriacus_reannotation/polished_genome_annotation/assembly/Ahypochondriacus_2.2_polished.softmasked.fasta
