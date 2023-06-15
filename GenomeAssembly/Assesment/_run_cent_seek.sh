#!/bin/sh
export PATH=$PATH:$HOME/perl5/perlbrew/perls/perl-5.28.1/bin
export PATH=$PATH:$HOME/soft/samtools-1.9/
export PATH=$PATH:$HOME/soft/bwa-0.7.17/bwa/
export PATH=$PATH:$HOME/soft/R-4.0.0/bin
export PATH=/usr/lib/x86_64-linux-gnu/libpcre2-8.so.0:$PATH
export PATH=/usr/lib/x86_64-linux-gnu/:$PATH
fasta=$1

# Analyse the ont reads by cent_Seeker
echo "centseeker started Analysing the ont reads "
soft/centromere_seeker/cent_seeker.sh -t soft/TRF/bin/trf -s ${fasta}  -m 'full' -v 1
