#$ -S /bin/sh
#$ -N blastnlocal
#$ -cwd
#$ -pe pe_slots 4
#$ -l mem_free=16G
#$ -o logs/$JOB_NAME.o$JOB_ID
#$ -e logs/$JOB_NAME.e$JOB_ID
while read file
do
	blastn -db /home/blastdb/nt_db/nt -query in/${file} -out /home/blast/${file}.txt
done < blast_fasta_list.txt
