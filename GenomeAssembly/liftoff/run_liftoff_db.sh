#!/bin/sh
PATH=$PATH:$HOME/soft/minimap2/
target_fa=$1
ref_fa=$2
ref_db=$3
output=$4
python liftoff.py -p 1 -r $ref_fa -db $ref_db -t $target_fa -o $output.gff

