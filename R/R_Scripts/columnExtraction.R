# This R script is to make a expression matrix from multiple files where the first column is the gene name and the remaining columns are the read counts
# Store the current working directory
current_dir <- getwd()

# Set the desired working directory (you can provide a relative path or use environment variables)
# modify ... to your prefered directory
setwd("...")

# Get the working directory
new_dir <- getwd()

# List all the files in the directory
files <- list.files(path = new_dir)

# Read the gene names from the first file
genes <- read.table(files[1], header = FALSE, sep = "\t")[, 5]

# Read the data from all files and combine them into a data frame
df <- do.call(cbind, lapply(files, function(fn) read.table(fn, header = FALSE, sep = "\t")[, 10]))
colnames(df) <- files
df <- cbind(genes, df)
# head(df)

# Write the combined data frame to a CSV file
output_path <- file.path(current_dir, "combinedSkeletal.csv")
write.table(df, file = output_path, sep = ",", qmethod = "double")
