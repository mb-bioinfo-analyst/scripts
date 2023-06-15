#!/bin/sh

SAMPLES=fastq/*
TRIMMOMATIC_HOME=/export/home/cmdtools/Trimmomatic-0.36
BOWTIE_INDEX=/export/home/References/bowtie_index/index
mkdir -p fastqc_logs
for sample in $SAMPLES
do
	sample=`basename $sample`
	fastq1=fastq/$sample/${sample}_1.fastq.gz
	fastq2=fastq/$sample/${sample}_2.fastq.gz
	
	fastq_out_1=fastq_qc/$sample/${sample}_1.fastq.gz
	fastq_out_1u=fastq_qc/$sample/${sample}_1u.fastq.gz
	fastq_out_2=fastq_qc/$sample/${sample}_2.fastq.gz
	fastq_out_2u=fastq_qc/$sample/${sample}_2u.fastq.gz
	
	echo $fastq1 $fastq2
	logfile=fastqc_logs/$sample.log
	mkdir -p fastq_qc/$sample
	outdir=tophat/$sample
	qsub -o $logfile  ~/share/qsub.1 java -jar $TRIMMOMATIC_HOME/trimmomatic-0.36.jar \
			PE -phred33 $fastq1 $fastq2 \
			$fastq_out_1 $fastq_out_1u $fastq_out_2 $fastq_out_2u \
			ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10  \
			LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:36 
			
	#tophat2 -p 32 --output-dir $outdir $BOWTIE_INDEX $fastq1 $fastq2
	#break
done 