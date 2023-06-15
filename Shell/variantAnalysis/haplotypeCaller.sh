#!/bin/sh


echo $1
BASE_SAMPLE_NAME=$1

TOTAL_SAMPLES=$2

mkdir -p vcfs
PROG_PATH=/export/home/apps/ETC/GATK/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar
GENOME_REF=/export/home/References/Human/Genome/b37/human_g1k_v37.fasta

BASE_DIR=`pwd | sed 's/varients.*//'`bams_sorted
echo $BASE_DIR

INPUTFILE=$BASE_DIR/$BASE_SAMPLE_NAME.spliced.sorted.bam
OUTPUTFILE=vcfs/$BASE_SAMPLE_NAME.spliced.sorted.bam.vcf
echo "----------------------------------------------------"	
echo "Apply HaplotypeCaller to $INPUTFILE" 
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

COMMAND="-jar $PROG_PATH \
		-T HaplotypeCaller \
		-R $GENOME_REF \
		-nct 4 \
		-dfrac 0.20 \
		-ploidy $TOTAL_SAMPLES \
		-I $INPUTFILE \
		-o $OUTPUTFILE" 
echo $COMMAND

if [ "$3" = "true" ];
then 
	java $COMMAND

fi

if [ ! -f "$OUTPUTFILE" ];
then 
	java $COMMAND
fi


ANNOVAR_HOME=/export/home/cmdtools/annovar/annovar

mkdir -p avinput

INPUTFILE=vcfs/$BASE_SAMPLE_NAME.spliced.sorted.bam.vcf
OUTPUTFILE=avinput/$BASE_SAMPLE_NAME.vcf.avinput
echo "----------------------------------------------------"	
echo "Converting $INPUTFILE to ANNOVAR Format" 
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

convert2annovar.pl -format vcf4 -allsample -withfreq  $INPUTFILE > $OUTPUTFILE

mkdir -p avfilter/$BASE_SAMPLE_NAME

INPUTFILE=avinput/$BASE_SAMPLE_NAME.vcf.avinput
OUTPUTFILE_PREFIX=avfilter/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME

echo "----------------------------------------------------"	
echo "Apply ANNOVAR Filter to $INPUTFILE" 
echo "Files will be generated with prefix $OUTPUTFILE."
echo "----------------------------------------------------"	

annotate_variation.pl -filter -out $OUTPUTFILE_PREFIX -build hg19 -dbtype snp138 $INPUTFILE $ANNOVAR_HOME/humandb/

mkdir -p annotated/$BASE_SAMPLE_NAME

INPUTFILE=$OUTPUTFILE_PREFIX.hg19_snp138_filtered
OUTPUTFILE_PREFIX=annotated/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME.annotated

echo "----------------------------------------------------"	
echo "Apply ANNOVAR Annotation to $INPUTFILE" 
echo "Files will be generated with prefix $OUTPUTFILE_PREFIX."
echo "----------------------------------------------------"	

annotate_variation.pl --buildver hg19 --geneanno -dbtype ensgene --outfile $OUTPUTFILE_PREFIX $INPUTFILE $ANNOVAR_HOME/humandb/

cut -f2-11 $OUTPUTFILE_PREFIX.exonic_variant_function > $OUTPUTFILE_PREFIX.exonic_variant_function.modified

grep "splicing*" $OUTPUTFILE_PREFIX.variant_function > $OUTPUTFILE_PREFIX.variant_function.spliced


cat $OUTPUTFILE_PREFIX.exonic_variant_function.modified $OUTPUTFILE_PREFIX.variant_function.spliced > $OUTPUTFILE_PREFIX.exonic_and_spliced_variant_function