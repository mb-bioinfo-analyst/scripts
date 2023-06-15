#!/bin/sh

mkdir -p sams
mkdir -p bams
mkdir -p bams_sorted
mkdir -p bams_logs

FILES=fastq/*
for file in $FILES
do
	BASE_SAMPLE_NAME=`basename $file`
	echo $BASE_SAMPLE_NAME
	LOGFILE=bams_logs/$BASE_SAMPLE_NAME.log
	qsub -o $LOGFILE ~/share/qsub.4 sh bam_generator.sh $BASE_SAMPLE_NAME
done 