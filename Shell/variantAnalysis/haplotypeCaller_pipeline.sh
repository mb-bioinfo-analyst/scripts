#!/bin/sh

mkdir -p varients_logs

BASE_DIR=`pwd | sed 's/varients.*//'`bams_sorted

echo $BASE_DIR 
FILES=$BASE_DIR/*.bam
for file in $FILES
do
	BASE_SAMPLE_NAME=`basename $file | sed 's/.spliced.sorted.bam//'`
	#echo $BASE_SAMPLE_NAME
	LOGFILE=varients_logs/$BASE_SAMPLE_NAME.log
	qsub -o $LOGFILE ~/share/qsub.4 sh annotation2.sh $BASE_SAMPLE_NAME 10
done 