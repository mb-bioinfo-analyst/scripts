#!/bin/sh

echo $1

BASE_SAMPLE_NAME=$1
GENOME_REF=/export/home/genome/human_g1k_v37.fasta
BED_FILE=/export/home/Oncopanel/Oncopanel_v2_1kGenomeb37.bed

mkdir -p sams
mkdir -p bams
mkdir -p bams_sorted

#INPUTFILE=fastq/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME.1.fastq
#OUTPUTFILE=fastq/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME.1.fastq.sai

#echo "----------------------------------------------------"	
#echo "Creating SAI file From File $INPUTFILE"
#echo "$OUTPUTFILE will be generated."
#echo "----------------------------------------------------"	

#if [ ! -f "$OUTPUTFILE" ]
#then
#	bwa aln -t 4 \
#		-f $OUTPUTFILE \
#		$GENOME_REF \
#		$INPUTFILE;
#fi	

#INPUTFILE=fastq/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME.2.fastq
#OUTPUTFILE=fastq/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME.2.fastq.sai

#echo "----------------------------------------------------"	
#echo "creating SAI file from File $INPUTFILE"
#echo "$OUTPUTFILE will be generated."
#echo "----------------------------------------------------"	

#if [ ! -f "$OUTPUTFILE" ]
#then
#	bwa aln -t 4 \
#		-f $OUTPUTFILE \
#		$GENOME_REF \
#		$INPUTFILE;
#fi		

OUTPUTFILE=bams/$BASE_SAMPLE_NAME.spliced.bam

echo "----------------------------------------------------"	
echo "Generating SAM File using FASTQ and SAI Files"
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

if [ ! -f "$OUTPUTFILE" ]
then 
#	bwa mem -t 4 \
#		-R '@RG\tID:$BASE_SAMPLE_NAME\tPL:illumina\tPU:ex\tLB:$BASE_SAMPLE_NAME\tSM:$BASE_SAMPLE_NAME' \
#		$GENOME_REF \
#		fastq/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME.1.fastq  \
#		fastq/$BASE_SAMPLE_NAME/$BASE_SAMPLE_NAME.2.fastq > $OUTPUTFILE
# --rg "PL:illumina\tLB:$BASE_SAMPLE_NAME\tSM:$BASE_SAMPLE_NAME" 
	bowtie2 --threads 8 -x ~/References/bowtie_index/index \
		--rg-id $BASE_SAMPLE_NAME \
		--rg "PL:illumina" --rg "LB:$BASE_SAMPLE_NAME" --rg "SM:$BASE_SAMPLE_NAME" \
		-1 fastq/$BASE_SAMPLE_NAME/${BASE_SAMPLE_NAME}_1.fastq.gz \
		-2 fastq/$BASE_SAMPLE_NAME/${BASE_SAMPLE_NAME}_2.fastq.gz \
		| samtools view --threads 8 -o $OUTPUTFILE -bh -L $BED_FILE 
	
fi

INPUTFILE=sams/$BASE_SAMPLE_NAME.fastq.sam
OUTPUTFILE=bams/$BASE_SAMPLE_NAME.fastq.bam

echo "----------------------------------------------------"	
echo "Converting BAM File $INPUTFILE into SAM"
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

#if [ ! -f "$OUTPUTFILE" ]
#then 
#	samtools view --threads 4 \
#		-o $OUTPUTFILE \
#		--reference $GENOME_REF \
#		-bh $INPUTFILE
#fi

INPUTFILE=bams/$BASE_SAMPLE_NAME.spliced.bam
OUTPUTFILE=bams_sorted/$BASE_SAMPLE_NAME.spliced.sorted.bam

echo "----------------------------------------------------"	
echo "Sorting Input File $INPUTFILE"
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

if [ ! -f "$OUTPUTFILE" ]
then 
	samtools sort --threads 8 \
		-o $OUTPUTFILE \
		--reference $GENOME_REF \
		$INPUTFILE
fi	

INPUTFILE=bams_sorted/$BASE_SAMPLE_NAME.spliced.sorted.bam
OUTPUTFILE=bams_sorted/$BASE_SAMPLE_NAME.spliced.sorted.bai

echo "----------------------------------------------------"	
echo "Indexing BAM FILE $INPUTFILE" 
echo "$OUTPUTFILE will be generated."
echo "----------------------------------------------------"	

if [ ! -f "$OUTPUTFILE" ]
then
	samtools index $INPUTFILE $OUTPUTFILE 
fi	 
	