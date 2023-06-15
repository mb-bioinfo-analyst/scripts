#!/bin/sh
# Fastqc
# qsub ./fastqc.sh /path/to/fastqs/

RUN_PATH=$1
cd $RUN_PATH
for file in $(ls $RUN_PATH)
do
    SAMPLE=`basename $file`
    soft/FastQCv0119/fastqc -t 1 ${SAMPLE} -o $RUN_PATH/qc_report
done
