#!/bin/bash
PATH=$PATH:$HOME/soft/ncbi-blast-2.9.0+/bin
BLASTDB=$HOME/blastdb
ctg=$1
blastn -db nt -query ${ctg} -out ${ctg}.out -remote
