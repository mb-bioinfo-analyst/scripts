#!/bin/sh
while read file
do
tar -zxvf ${file}
done < nt_Files.txt