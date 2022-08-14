## Code

All code used for polishing, masking and reannotation of the A. hypochondriacus reference genome.

### Order of usage:

- code/genome_polishing/
polish the previously published A. hypochondriacus reference genome

- code/repeat_masking/
to prepare computational annotation, softmask repetitive elements in the polished genome

- code/braker2/
perform computational annotation of the softmasked reference genome using BRAKER2

- code/isoseq_assembly/
assembly long read transcript sequencing data and compare effects of genome polishing on reported completeness

- code/merge_annotation/
merge computational annotation with long-read transcript sequencing data and process output into genome annotation v2.2

- code/annotation_analysis/
identify flavonoid and betalain pathway genes, as well as MYB transcription factors in the genome annotation v2.2
