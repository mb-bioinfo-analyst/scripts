#!/bin/bash

file=$1
motif=$2
motif_n=$3

echo -e ">"$motif > $file.$motif$motif_n
for ((i=1; i<=$motif_n; i++)); do echo -n $motif; done >> $file.$motif$motif_n

seqkit locate --ignore-case --degenerate --pattern-file $file.$motif$motif_n $file -o $file.$motif$motif_n.tsv


echo -e "seqnames\tstart\tend\twidth\tstrand" > $file.$motif$motif_n.GRanges.nonfiltered
awk '{print $1"\t"$5"\t"$6"\t"$6-$5"\t"$4}' $file.$motif$motif_n.tsv |                      grep -v start >> $file.$motif$motif_n.GRanges.nonfiltered
awk 'NR>1 {print $1"\tSeq\tgene\t"$2"\t"$3"\t.\t"$5"\t.\tNA"}' $file.$motif$motif_n.GRanges.nonfiltered > $file.$motif$motif_n.GRanges.nonfiltered.gff


awk '{print $1"\t"$5"\t"$6"\t"$6-$5"\t"$4}' $file.$motif$motif_n.tsv | sort -k 1,1 -k 2,2 | grep -v start >  $file.$motif$motif_n.out
echo -e "seqnames\tstart\tend\twidth\tstrand" > $file.$motif$motif_n.GRanges
n=0; j1=0; j2=0; j3=0; j1old=0; j3old=0; str="";
for i in `cat $file.$motif$motif_n.out`; 
 do 
  for j in $i; 
   do 
    n=$((n+1)); 
    str=$str$j"\t"; 
    if [ $n -eq 1 ]; then j1=$j; fi; 
    if [ $n -eq 2 ]; then j2=$j; fi; 
    if [ $n -eq 3 ]; then j3=$j; fi; 
    if [ $j1 != $j1old ]; then j3old=$j3; fi; 
    if [ $n -gt 4 ] && [ $j2 -gt $j3old ]; then echo -e $str >> $file.$motif$motif_n.GRanges; j3old=$j3; fi; 
    if [ $n -gt 4 ]; then n=0; str=""; j1old=$j1; fi; 
   done; 
 done

awk 'NR>1 {print $1"\tSeq\tgene\t"$2"\t"$3"\t.\t"$5"\t.\tNA"}' $file.$motif$motif_n.GRanges > $file.$motif$motif_n.gff
