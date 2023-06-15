#!/bin/sh

SAMPLES=fastq/*
FASTQC_HOME=/export/home/cmdtools/FastQC
mkdir -p fastqc_rpt
mkdir -p fastqc_logs123
for sample in $SAMPLES
do
	sample=`basename $sample`
	fastq1=fastq/$sample/${sample}_1.fastq.gz
	fastq2=fastq/$sample/${sample}_2.fastq.gz
	
	logfile=fastqc_logs123/$sample.log
	echo $fastq1 $fastq2
	mkdir -p fastqc_rpt/$sample
	qsub -o $logfile   ~/share/qsub.1 $FASTQC_HOME/fastqc \
			$fastq1 $fastq2 \
			--outdir=fastqc_rpt/$sample
			
	#tophat2 -p 32 --output-dir $outdir $BOWTIE_INDEX $fastq1 $fastq2
	#break
done 