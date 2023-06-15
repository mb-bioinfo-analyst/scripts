#!/bin/sh
#conda install -c bioconda shasta
input =$1
out_dir=$3
threads=$5
shasta --input ${input } --config Nanopore --threads ${threads } --assemblyDirectory ${out_dir }