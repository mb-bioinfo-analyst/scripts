#!/bin/sh
export BUSCO_CONFIG_FILE=$HOME/soft/busco4/busco/config/config.ini
export AUGUSTUS_CONFIG_PATH="/home/soft/augustus-3.3.3/config/"
export PATH="/home/soft/augustus-3.3.3/bin:$PATH"
export PATH="/home/soft/augustus-3.3.3/scripts:$PATH"


species=$1
fasta=$2
output=$3
lineage=$4

if [ ! -f ${fasta} ];  then echo "Run interrupted because file not found: "${fasta}; exit 1; fi
if [ ! -d ${lineage} ]; then echo "Run interrupted because path not found: "${lineage}; exit 1; fi
if [ -d ${output} ]; then echo "Run interrupted because "${output}" already exists."; exit 1; fi

###
echo "BUSCO is starting."                > _${output}.out;
busco -i ${fasta} -l ${lineage} -o ${output} -m genome -c 1 --augustus_species ${species}
out_file=${PWD}/run_${output}/short_summary_${output}.txt
if [ -f ${out_file} ]; then 
echo "BUSCO finished. Output "${out_file} >> _${output}.out;
cat ${out_file}                           >> _${output}.out; 
fi


###
if [ ! -d run_${output} ]; then mkdir run_${output}; fi
out_file=${PWD}/run_${output}/${output}.out

echo "\nAugustus is starting." >> _${output}.out;
augustus --species=${species} ${fasta} > ${out_file}

if [ -f ${out_file} ]; then 
gene_n=`grep '# end gene g' ${out_file} | wc -l`; 
echo "Augustus finished with "${gene_n}" predicted genes in the file "${out_file} >> _${output}.out; 
fi
