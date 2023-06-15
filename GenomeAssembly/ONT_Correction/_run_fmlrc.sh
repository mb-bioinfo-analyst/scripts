#!/bin/sh
PATH=$PATH:$HOME/soft/fmlrc/example/ropebwt2
PATH=$PATH:$HOME/soft/fmlrc
datadir=$1
ont_reads=$2
ngs_reads=$3
threads=$4
if [ ! -d ${datadir} ]; then mkdir ${datadir}; fi
#build the bwt
if [ ! -d ${datadir}/temp ]; then mkdir ${datadir}/temp; fi
if [ ! -f ${datadir}/comp_msbwt.npy ]; then
    gunzip -c ${ngs_reads} | awk "NR % 4 == 2" | sort -T ./${datadir}/temp | tr NT TN | ropebwt2 -LR | tr NT TN | fmlrc-convert ${datadir}/comp_msbwt.npy
fi
#run fmlrc
#fmlrc -p ${threads} -e 50 ${datadir}/comp_msbwt.npy ${ont_reads} ${datadir}/corrected_reads.fa
fmlrc -p ${threads} ${datadir}/comp_msbwt.npy ${ont_reads} ${datadir}/corrected_reads.fa
