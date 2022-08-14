#!/bin/bash

# run sqanti correction and filtering
# preliminary genome annotation is used to compare against, but this only effects the pdf output


/home/tom/Documents/tools/SQANTI3-4.2/sqanti3_qc.py \
        data/isoseq/mapping_and_collapse/combined.collapsed.min_fl_2.filtered.gff \
        data/braker2/polished_prot_rna/braker.gtf \
        polished_genome_annotation/assembly/Ahypochondriacus_2.2_polished.softmasked.fasta \
        -d data/isoseq/sqanti/output_polished/ \
        -n 6


/home/tom/Documents/tools/SQANTI3-4.2/sqanti3_qc.py \
	data/isoseq/mapping_and_collapse_old_genome/combined.collapsed.min_fl_2.filtered.gff \
	reference_genomes/Ahypochondriacus/annotation/Ahypochondriacus_459_v2.1.gene_exons.gff3 \
	/home/tom/Documents/reference_genomes/Ahypochondriacus/assembly/Ahypochondriacus_459_v2.0.softmasked.nospace.underscore.fa \
	-d data/isoseq/sqanti/output_old_genome/ \
	-n 6
