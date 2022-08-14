## Input

Braker2 protein input using the plant sequences from orthoDB (downloaded from: https://v100.orthodb.org/download/odb10_plants_fasta.tar.gz) as well as the protein sequences from amaranthus cruentus (removed asterisks and space in fasta header)

The downloaded dataset contains sequences from 117 embryophyte species.

wget https://v100.orthodb.org/download/odb10_plants_fasta.tar.gz
tar -xvf odb10_plants_fasta.tar.gz
% write all into the same file:
cat plants/Rawdata/* > protein_db.fasta

% also add the Cruentus sequences:
cat /projects/ag-stetter/twinkle/Amaranthus_cruentus/Amacr_pep_nospace.fa >> protein_db.fasta
% removed asterisk
sed 's/\*//' protein_db.fasta > protein_db.fa

-> in total 3536219 plant protein sequences
Since I added the Cruentus sequences, the toal number of species is now 118.
