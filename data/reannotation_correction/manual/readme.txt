## Manual

Manual correction of target genes of the newly generated annotation. The sequenced AmMYBl1 was mapped against the polished reference genome using minimap2.

Command used for the mapping:
/hom/tom/Documents/tools/minimap2/minimap2 -x splice \
	-o data/reannotation_correction/manual/mybl1.paf \
	/hom/tom/Documents/tools/minimap2_index/polished_Ahyp_reference.mmi \
	raw_data/mybl1_sequencing/MYBL1_assembled.fasta
/hom/tom/Documents/tools/minimap2/minimap2 -x splice \
	-a \
	-o data/reannotation_correction/manual/mybl1.sam \
	/hom/tom/Documents/tools/minimap2_index/polished_Ahyp_reference.mmi \
	raw_data/mybl1_sequencing/MYBL1_assembled.fasta

The generated sam file was used in order to manually correct the annotated sequence of the MYBl1 gene.
Edited the position of the MYBl1 gene to match the mapped positions of the sequencing from Julio. I edited the 4th exon to start one base earlier.
In the mapped read there was a G insertion between exon 3 and exon 4. In the reference there was also a G in the reference before exon 4. The base likely remained unmapped to create a canonical
splice junction between exon 3 and 4. I extended the start of exon 4 by one position in comparison to the mapped sequencing result.
