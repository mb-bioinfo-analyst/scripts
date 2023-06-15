#!/bin/sh

SAMPLES=fastq_qc/*
HISEQ_INDEX=/export/home/References/hisat2_index/index
HISAT2_PATH=/export/home/cmdtools/hisat2-2.0.5
mkdir -p hiseq_logs
mkdir -p sam
for sample in $SAMPLES
do
	sample=`basename $sample`
	fastq1=fastq_qc/$sample/${sample}_1.fastq.gz
	fastq2=fastq_qc/$sample/${sample}_2.fastq.gz
	samoutput=sam/${sample}.fastq.sam
	#echo $fastq1 $fastq2
	logfile=hiseq_logs/$sample.log
	#mkdir -p tophat/$sample
	#outdir=tophat/$sample
	#
	qsub -o $logfile  ~/share/qsub.8 hisat2 -p 8 -x $HISEQ_INDEX -1 $fastq1 -2 $fastq2 -S $samoutput
done 