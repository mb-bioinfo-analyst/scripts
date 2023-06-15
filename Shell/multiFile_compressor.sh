#!/bin/sh

FILES=`find fastq -type f -name "*.fastq"`

for file in $FILES
do 
	qsub ~/share/qsub.1 gzip $file
done 