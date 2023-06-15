#!/bin/sh
# ./_run_ra_2.sh -x ont -t 4 ont.fasta.gz ngs.fasta.gz path_to_output_file/
PATH=$PATH:$HOME/soft/racon/build/bin/:${PATH}
PATH=$PATH:$HOME/soft/minimap2/:${PATH}
PATH=$PATH:$HOME/soft/ra/build/bin/
ont_reads=$1
ngs_reads=$2
path_out=$3
threads=$4
ra -x ont -t ${threads} ${ont_reads} ${ngs_reads} > ${path_out}assembly.fasta

