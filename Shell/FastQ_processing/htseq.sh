#!/bin/sh

SAMPLES=bam/*
GENOME_REF=/export/home/References/GRCh37_UCSC.fa

mkdir -p htseq_log
mkdir -p htseq
for sample in $SAMPLES
do
	sample=`basename $sample`
	INPUTFILE=bam/${sample}
	OUTPUTFILE=htseq/${sample}.htseq

	logfile=htseq_log/$sample.log

	qsub -o $OUTPUTFILE  ~/share/qsub.8 \
	htseq-count -f bam $INPUTFILE hg19_genes.gtf

done 