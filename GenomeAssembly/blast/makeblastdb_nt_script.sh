#!/bin/sh
while read file
do
    makeblastdb -dbtype nucl -in ${file}.fasta -out nt
done < blast_nt_Files.txt