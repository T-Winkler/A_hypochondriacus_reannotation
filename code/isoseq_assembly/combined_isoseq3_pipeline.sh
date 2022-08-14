#!/bin/bash -l
#SBATCH -D /home/twinkle1/projects/A_hypochondriacus_reannotation/
#SBATCH -t 12:00:00
#SBATCH -J isoseq3
#SBATCH -o logs/isoseq3/mappingLog-%j.txt
#SBATCH --nodes=1-1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64gb


source $CONDA_PREFIX/etc/profile.d/conda.sh
conda activate isoseq3

module load samtools/1.13

ISOSEQOUT=data/isoseq/isoseq3_pipeline/
mkdir -p $ISOSEQOUT

# flnc reads were created using the following command, removing artificial concatemers and filtering out all genes without Poly-A tail
# using respective primers of the different datasets
#isoseq3 refine $REFINEIN $PRIMERS $REFINEOUT --require-polya


# merge all flnc reads into a single file
samtools merge "$ISOSEQOUT"combined.merged_flnc.bam /home/twinkle1/isoseq_raw_reads/*bam


# clustering of identical reads

IN="data/isoseq3_pipeline/combined.merged_flnc.bam"
OUT="data/isoseq3_pipeline/combined.merged_clustered.bam"

isoseq3 cluster	"$IN" "$OUT" --verbose --use-qvs







