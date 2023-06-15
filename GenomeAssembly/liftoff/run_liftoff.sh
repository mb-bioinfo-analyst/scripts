#!/bin/sh
PATH=$PATH:$HOME/soft/minimap2/
target_fa=$1
ref_fa=$2
ref_gff=$3
output=$4
python liftoff.py -p 1 -r $ref_fa -g $ref_gff -t $target_fa -o $output.gff

