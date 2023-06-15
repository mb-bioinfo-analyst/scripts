#!/usr/bin/Rscript

###############################

# The paths to the GTF and FASTA files are specified.
# The GTF annotation is loaded using import.gff() and reduced to unique gene regions using reduce() and split().
# The FASTA file is opened using FaFile() and open().
# GC numbers and widths are added to the reduced GTF using letterFrequency() and getSeq().
# The calc_GC_length() function is defined to calculate GC content and length for each gene.
# The function is applied to each gene using sapply() and the results are stored in the output variable.
# Column names "Length" and "GC" are assigned to the output data frame.
# The write.table() function is used to write the output to a tab-separated file named "GC_lengths.tsv".


###############################


# Load required libraries
library(GenomicRanges)
library(rtracklayer)
library(Rsamtools)

# Specify the paths to the GTF and FASTA files
GTFfile <- "genes.gtf"
FASTAfile <- "genome.fa"

# Load the GTF annotation and reduce it to unique gene regions
GTF <- import.gff(GTFfile, format = "gtf", genome = "hg19", feature.type = "exon")
grl <- reduce(split(GTF, elementMetadata(GTF)$gene_id))
reducedGTF <- unlist(grl, use.names = TRUE)
elementMetadata(reducedGTF)$gene_id <- rep(names(grl), elementNROWS(grl))

# Open the FASTA file
FASTA <- FaFile(FASTAfile)
open(FASTA)

# Add GC numbers and widths to the reduced GTF
elementMetadata(reducedGTF)$nGCs <- letterFrequency(getSeq(FASTA, reducedGTF), "GC")[, 1]
elementMetadata(reducedGTF)$widths <- width(reducedGTF)

# Create a function to calculate GC content and length for each gene
calc_GC_length <- function(x) {
  nGCs <- sum(elementMetadata(x)$nGCs)
  width <- sum(elementMetadata(x)$widths)
  c(width, nGCs / width)
}

# Apply the function to each gene and store the results in 'output'
output <- t(sapply(split(reducedGTF, elementMetadata(reducedGTF)$gene_id), calc_GC_length))
colnames(output) <- c("Length", "GC")

# Write the output to a tab-separated file
write.table(output, file = "GC_lengths.tsv", sep = "\t")
