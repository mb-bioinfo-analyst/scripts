#!/bin/sh
# ./run_flye.sh input_file.fasta.gz path_to_input_file/ out_dir genome_size(m/g) threads
# ./run_flye.sh ecoli.fasta ecoli/ ecoli 250m 4
#$ -S /bin/sh
#$ -cwd
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
PATH=$PATH:$HOME/soft/Flye/bin/
PATH=$PATH:$HOME/crciv/anaconda3/bin/python
PATH=$PATH:$HOME/anaconda3/lib/python3.8/site-packages/
file=$1
path_in=$2
out_dir=$3
genome_size=$4
threads=$5
flye --nano-raw ${path_in}${file} --out-dir ${out_dir} --genome-size ${genome_size} --threads ${threads} --iterations 5