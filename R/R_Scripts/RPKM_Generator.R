#################################
# The input table is read using read.table() and stored in the countMatrix variable.
# The number of columns in the matrix is stored in numColumns.
# The output RPKM matrix is initialized as an empty list named rpkmMatrix.
# The row names of the count matrix are assigned from the first column of countMatrix.
# The RPKM calculation loop iterates over columns 2 to numColumns - 1.
# Within the loop, the column data and lengths are assigned to more descriptive variable names (data and lengths, respectively).
# The total mapped reads per sample is calculated and stored in totalReads.
# The RPKM value is calculated using the formula and stored in the rpkmMatrix list.
# The gene names are assigned to the first element of rpkmMatrix.
# The write.table() function is used to write the RPKM matrix to the output file, with modified parameter names for readability.


#################################


# Read the input table
countMatrix <- read.table("CountMatrix.txt", sep = "\t", header = TRUE)

numColumns <- ncol(countMatrix)
rpkmMatrix <- list()
rownames(countMatrix) <- countMatrix[, 1]

# Calculate RPKM values for each column
for (i in 2:(numColumns - 1)) {
  data <- countMatrix[, i]
  lengths <- countMatrix[, numColumns]
  totalReads <- sum(as.numeric(countMatrix[, i]))  # Total mapped reads per sample
  rpkmMatrix[[i]] <- (10^9) * (as.numeric(data)) / (as.numeric(lengths) * totalReads)
  rpkmMatrix[[1]] <- countMatrix[[1]]
}

# Write the RPKM matrix to a file
write.table(rpkmMatrix, file = "output_table_rpkm.txt",
            sep = "\t", quote = FALSE, row.names = FALSE)
