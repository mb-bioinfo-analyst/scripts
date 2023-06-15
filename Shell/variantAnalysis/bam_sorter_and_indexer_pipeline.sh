#!/bin/sh

FILES=bams/*
for file in $FILES 
do
	echo $file
	sh bam_sorter_and_indexer.sh $file
done
