#!/bin/bash
#$ -S /bin/sh
#$ -N blastdb
#$ -cwd
#$ -pe pe_slots 2
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
while read file; do
    wget ${file} -b
done < blast_nt_Files.txt