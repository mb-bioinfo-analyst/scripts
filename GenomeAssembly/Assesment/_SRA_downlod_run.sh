#!/bin/sh
export PATH=$PATH:$HOME/soft/sratoolkit.2.10.9-ubuntu64/bin

prefetch $(<SraAccList.txt)
fastq-dump --outdir /home/sra_data/fastq --split-files $(</home/SraAccList.txt)
