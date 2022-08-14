#!/bin/bash -l
#SBATCH -D /home/twinkle1/projects/A_hypochondriacus_reannotation/
#SBATCH -t 16:00:00
#SBATCH -J SRA
#SBATCH -o logs/mappingLog-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=64gb
#SBATCH --job-name="SRA_unpack"

# requires cheops1 for newer library versions
# prefetch command has to be run on the headnode before, as it requires internet access
# Commands used:
# download file, show progress, increase default max size so that the download starts
# tools/sratoolkit.2.11.2-centos_linux64/bin/prefetch -p -O /projects/ag-stetter/twinkle/lightfoot_WGS_short_reads/ --max-size 30G SRR2106212

QCOUT=data/NextPolish/QC

# set working directory
cd /projects/ag-stetter/twinkle/lightfoot_WGS_short_reads/SRR2106212/

# before running the fastq-dump command, switch off "Enable Remote Access" by running sratoolskit/bin/vdb-config -i
# split into fastq files
/home/twinkle1/tools/sratoolkit.2.11.2-centos_linux64/bin/fastq-dump --split-3 --verbose SRR2106212.sra

# set working directory
cd /home/twinkle1/projects/A_hypochondriacus_reannotation

# gzip the resulting fastq files
# Even though there is an option to gzip it directly using the fastq-dump command, the option is deprecated and should no longer be used
gzip /projects/ag-stetter/twinkle/lightfoot_WGS_short_reads/SRR2106212/SRR2106212_1.fastq
gzip /projects/ag-stetter/twinkle/lightfoot_WGS_short_reads/SRR2106212/SRR2106212_2.fastq

# remove sra file afterwards
rm /projects/ag-stetter/twinkle/lightfoot_WGS_short_reads/SRR2106212/SRR2106212.sra

# quality control:
module load fastqc/0.11.9

fastqc -o /scratch/twinkle1/NextPolish/QC/ -t 8 \
        /projects/ag-stetter/twinkle/lightfoot_WGS_short_reads/SRR2106212/SRR2106212_1.fastq.gz \
        /projects/ag-stetter/twinkle/lightfoot_WGS_short_reads/SRR2106212/SRR2106212_2.fastq.gz
