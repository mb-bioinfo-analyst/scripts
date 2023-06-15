#!/bin/sh

SAMPLES=bam/*
GENOME_REF=/export/home/References/GRCh37_UCSC.fa

mkdir -p samtobam_log
mkdir -p bam
for sample in $SAMPLES
do
	sample=`basename $sample`
	INPUTFILE=bam/${sample}
	OUTPUTFILE=bam1/${sample}

	logfile=samtobam_log/$sample.log

	qsub -o $logfile  ~/share/qsub.8 samtools view --threads 8 \
		-o $OUTPUTFILE \
		--reference $GENOME_REF \
		-bf 1 $INPUTFILE
done 