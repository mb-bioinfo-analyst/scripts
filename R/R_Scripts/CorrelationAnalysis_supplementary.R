# this R script is for analysing corelation of specific genes in the given dataset and visualize these correlation results.
library(ggplot2)

# Read the data from a user-selected file
data <- read.table(file.choose(), header = TRUE, sep = "\t")
rownames(data) <- data$genes
data$genes <- NULL

genes.list <- c("AKT1", "AKT2", "FGF19", "PIK3CA", "FGFR4", "SRC", "CTGF", "EGR1", "PTEN", "ERBB2", "EGFR", "STAT3")

# Calculate the standard deviation
sd <- apply(data, 1, sd, na.rm = TRUE)

# Select genes with standard deviation greater than 0.01
selected.genes <- names(sd[sd > 0.01])
data.selected <- data[selected.genes, ]

# Calculate the correlation matrix
corr <- cor(t(data.selected), method = "pearson")
corr <- as.data.frame(corr)
corr

# Filter correlations based on conditions
filtered_corr <- corr[(abs(corr$FGF19) > 0.5 & abs(corr$FGFR4) > 0.6 & corr$EGR1 < -0.25), ]
filtered_corr

# Write the filtered correlation matrix to a file
# modify ... to your specific directory
output_path <- file.path("...", "cormatrix_genelist.txt")
write.table(filtered_corr, file = output_path, sep = "\t")

# Create a heatmap of the correlation matrix for selected genes
heatmap(as.matrix(corr[genes.list, ]))

# Create scatterplot matrices
pairs(~ AKT1 + AKT2 + AKT3 + PIK3CA + FGF19 + FGFR4 + SRC + CTGF + EGR1 + PTEN + ERBB2 + EGFR, data = as.matrix(corr[genes.list, ]), main = "Simple Scatterplot Matrix", pch = 19)

# Install and load required packages for additional visualization
install.packages("corrplot")
install.packages("PerformanceAnalytics")
library(corrplot)
library(PerformanceAnalytics)

# Create a correlation plot using corrplot
corrplot(as.matrix(corr[genes.list, ]), type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

# Create a correlation chart using PerformanceAnalytics
chart.Correlation(as.matrix(corr[genes.list, ]), histogram = TRUE, pch = 19)

# Write the complete correlation matrix to a file
write.table(corr, file = "cormatrix.txt", sep = "\t")

# Create a heatmap for filtered correlations
filtered_matrix <- as.matrix(corr[(abs(corr$FGF19) > 0.4 & abs(corr$FGFR4) > 0.6), ])
heatmap(filtered_matrix)

# Create a scatterplot between specific genes
plot(t(data["EGFR", ]), t(data["ERK2", ]))
