#!/bin/sh
PATH=$PATH:/usr/bin/java/

prefix=$1
nanopore_raw=$2
genomeSize=$3
minReadLength=$4
minOverlapLength=$5
path_out=${prefix}/output

$HOME/soft/canu-1.8/*/bin/canu \
-p ${prefix} \
-d ${path_out} \
-nanopore-raw ${nanopore_raw} \
genomeSize=${genomeSize} \
minReadLength=${minReadLength} \
minOverlapLength=${minOverlapLength} \
useGrid=false


