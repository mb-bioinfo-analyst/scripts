#!/bin/sh
# Fastqc
# qsub ./fastqc.sh /path/to/fastqs/
#$ -o /home/referenceAssembly/$JOB_NAME.o$JOB_ID
#$ -e /home/referenceAssembly/$JOB_NAME.e$JOB_ID
# Load modules
#module load star
PATH=$PATH:$HOME/soft/STAR/bin/Linux_x86_64/STAR
PATH=$PATH:$HOME/soft/STAR/bin/Linux_x86_64
PATH=/usr/bin/java:$PATH
PATH=$PATH:$HOME/soft/FastQC
PATH=$PATH:$HOME/python/Python-3.6.9
PATH=$PATH:$HOME/.local/bin/cutadapt
PATH=$PATH:$HOME/soft/TrimGalore-0.6.0
PATH=$PATH:$HOME/perl5/perlbrew/perls/perl-5.28.1/bin

GENOMEDIR="/home/referenceAssembly/"

for f in *fastq 
do STAR --genomeDir $GENOMEDIR/STAR --readFilesIn $f --runThreadN 8 --outFileNamePrefix $f.
done
