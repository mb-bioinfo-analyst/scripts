#!/bin/sh


GENOME_REF=/export/home/genome/human_g1k_v37.fasta
file=$1

filename=`basename $file`

OUTPUTFILE=`echo $file | sed 's/\.sam*//'`
echo $OUTPUTFILE
#samtools view \
#	-o $OUTPUTFILE \
#	--reference $GENOME_REF \
#	-bh $file
	
INPUTFILE=$OUTPUTFILE
temp_file_name=`basename $OUTPUTFILE`
OUTPUTFILE=bams_sorted/`echo $temp_file_name | sed 's/bam$/sorted\.bam/'`

echo "----------------------------------------------------"	
echo "Sorting Input File $INPUTFILE"
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

samtools sort \
	-o $OUTPUTFILE \
	--reference $GENOME_REF \
	$INPUTFILE


INPUTFILE=$OUTPUTFILE
OUTPUTFILE=`echo $INPUTFILE | sed 's/bam$/bai/'`

echo "----------------------------------------------------"	
echo "Indexing BAM FILE $INPUTFILE" 
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

samtools index $INPUTFILE $OUTPUTFILE
	
mkdir -p s_vcfs	
PROG_PATH=/export/home/ETC/GATK/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar
GENOME_REF=/export/home/References/Human/Genome/b37/human_g1k_v37.fasta


#INPUTFILE=$OUTPUTFILE

temp_file_name=`basename $INPUTFILE`
OUTPUTFILE=s_vcfs/$temp_file_name.vcf

echo "----------------------------------------------------"	
echo "Apply HaplotypeCaller to $INPUTFILE" 
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	
java -jar $PROG_PATH -T HaplotypeCaller -R $GENOME_REF -I $INPUTFILE -o $OUTPUTFILE 
#echo $file
