#!/bin/sh
# Fastqc
# qsub ./fastqc.sh /path/to/fastqs/
#$ -o /sra_data/$JOB_NAME.o$JOB_ID
#$ -e /sra_data/$JOB_NAME.e$JOB_ID
# Load modules
#module load star
PATH=/usr/bin/bwa:$PATH
PATH=$PATH:$HOME/soft/STAR/bin/Linux_x86_64/STAR
PATH=$PATH:$HOME/soft/STAR/bin/Linux_x86_64
PATH=/usr/bin/java:$PATH
PATH=$PATH:$HOME/soft/FastQC
PATH=$PATH:$HOME/python/Python-3.6.9
PATH=$PATH:$HOME/.local/bin/cutadapt
PATH=$PATH:$HOME/soft/TrimGalore-0.6.0
PATH=$PATH:$HOME/perl5/perlbrew/perls/perl-5.28.1/bin

outputDir="/home/sra_data/bwa_single/bamFiles"
inputDir="/home/sra_data/bwa_single"

for f in *sam
do 
soft/samtools-1.9/samtools view -@ 4 -b $inputDir/$f > $outputDir/$f.bam
done
