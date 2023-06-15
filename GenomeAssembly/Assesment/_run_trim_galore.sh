#!/bin/sh
# This script trims adapters by trim_galore
# ./_run_trim_galore.sh ${prefix} ${out_folder}

RUN_PATH=$1
out_folder=$2
length=$3

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

PATH=$PATH:/usr/bin/java
PATH=$PATH:$HOME/soft/FastQC
PATH=$PATH:$HOME/python/Python-3.6.9
PATH=$PATH:$HOME/.local/bin/cutadapt
PATH=$PATH:$HOME/soft/TrimGalore-0.6.0
PATH=$PATH:$HOME/perl5/perlbrew/perls/perl-5.28.1/bin
#module load python-3.6.3
#module load java-1.8.0_40
#module load fastqc
for file in $(ls $RUN_PATH)
do
    prefix=`basename $file | cut --bytes=1-11`
	trim_galore --fastqc --length ${length} --paired --output_dir ${out_folder} ${prefix}_1.fastq ${prefix}_2.fastq
done
