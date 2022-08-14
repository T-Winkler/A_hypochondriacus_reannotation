#!/bin/bash -l
#SBATCH -D /home/twinkle1/projects/A_hypochondriacus_reannotation/
#SBATCH -t 55:00:00
#SBATCH -J braker
#SBATCH -o logs/braker/mappingLog-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=84gb

# run on cheops1
# this script is used to run braker2 in both RNAseq and protein mode

source $CONDA_PREFIX/etc/profile.d/conda.sh
conda activate /opt/rrzk/software/conda-envs/braker2

module load samtools

# it is recommended to merge the separate bam files beforehand, as specifying many files can cause issues with braker
samtools merge --threads 7 /scratch/twinkle1/clouse_reads_merged.bam \
	/scratch/twinkle1/STAR_mappings/SRR_0_Aligned.sortedByCoord.out.bam \
	/scratch/twinkle1/STAR_mappings/SRR_1_Aligned.sortedByCoord.out.bam \
	/scratch/twinkle1/STAR_mappings/SRR_2_Aligned.sortedByCoord.out.bam \
	/scratch/twinkle1/STAR_mappings/SRR_3_Aligned.sortedByCoord.out.bam \
	/scratch/twinkle1/STAR_mappings/SRR_4_Aligned.sortedByCoord.out.bam \
	/scratch/twinkle1/STAR_mappings/SRR_5_Aligned.sortedByCoord.out.bam \
	/scratch/twinkle1/STAR_mappings/SRR_6_Aligned.sortedByCoord.out.bam \
	/scratch/twinkle1/STAR_mappings/SRR_7_Aligned.sortedByCoord.out.bam

# it is unnecessary, however, to filter the bam files beforehand
# see (https://github.com/Gaius-Augustus/BRAKER/issues/241)

# run braker in RNAseq and protein mode:

braker.pl --AUGUSTUS_CONFIG_PATH=/home/twinkle1/tools/config/ \
	--etpmode \
	--prot_seq=data/braker2/input/protein/protein_db.fasta \
	--genome=polished_genome_annotation/assembly/Ahypochondriacus_2.2_polished.softmasked.fasta \
	--softmasking \
	--species=polished_prot_rna \
	--bam=/scratch/twinkle1/clouse_reads_merged.bam \
	--cores=8 \
	--workingdir=/scratch/twinkle1/braker2/polished_prot_rna

# copy braker output files to other partition
cp -r /scratch/twinkle1/braker2/polished_prot_rna data/braker2/polished_prot_rna/
cp -r /scratch/twinkle1/braker2/prot_run/ data/braker2/polished_prot/
