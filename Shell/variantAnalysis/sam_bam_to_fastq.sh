#!/bin/sh

echo $1

GENOME_REF=/export/home/References/Human/Genome/b37/human_g1k_v37.fasta
GENOME_REF=/export/home/genome/human_g1k_v37.fasta
PICARD_HOME=/export/home/cmdtools/picard/build/libs

S=("C101676T" "C107434T")
BASE_FILES=/export/home/bams/*

for file in $BASE_FILES
do 
	INFILE=$file
	INFILE=`echo $INFILE`
	
	filename=`basename $INFILE`
	SAMPLE_ID=`echo $filename | sed 's/_.*//'`
	OUTPUT_FILE_BASE=`echo $filename | sed 's/.fastq.*//'`
	LOGFILE
	mkdir -p $SAMPLE_ID
	OUTFILE1=$SAMPLE_ID/$OUTPUT_FILE_BASE.picrad.1.fastq
	OUTFILE2=$SAMPLE_ID/$OUTPUT_FILE_BASE.picrad.2.fastq
	echo $SAMPLE_ID $OUTFILE
	
	qsub -o java -jar $PICARD_HOME/picard.jar SamToFastq \
				INPUT=$INFILE FASTQ=$OUTFILE1 \
				SECOND_END_FASTQ=$OUTFILE2
done 