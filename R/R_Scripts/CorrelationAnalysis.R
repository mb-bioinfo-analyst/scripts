##############################

# The script reads the data from a user-selected file using read.table(), sets the row names, and removes the "Description" column.
# The genes of interest are specified in the genes.list variable.
# The script calculates the standard deviation of the data and selects genes with a standard deviation greater than 0.01.
# The correlation matrix is computed using cor() and stored in the corr data frame.
# The script filters the correlations based on specific conditions and creates a heatmap for the selected genes using heatmap().

##############################

# Install and load required packages
install.packages("corrplot")
library(corrplot)
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
library(ggplot2)
library(gplots)
library(RColorBrewer)

# Read the data from a user-selected file
data <- read.table(file.choose(), header = TRUE, sep = "\t")
rownames(data) <- data$Description
data$Description <- NULL

# Select the genes to analyze
genes.list <- c("FGF19", "FGFR4", "SRC", "CTGF", "EGR1", "PTEN", "PDPK1", "ERBB2", "EGFR")

# Calculate the standard deviation
sd <- apply(data, 1, sd, na.rm = TRUE)

# Select genes with standard deviation greater than 0.01
selected.genes <- names(sd[sd > 0.01])
data.selected <- data[selected.genes, ]

# Calculate the correlation matrix
corr <- cor(t(data.selected), t(data.selected[genes.list,]))
corr <- as.data.frame(corr)
corr

# Filter correlations based on conditions
filtered_corr <- corr[(abs(corr$FGF19) > 0.5 & abs(corr$FGFR4) > 0.6 & corr$EGR1 < -0.25), ]
filtered_corr

# Create a heatmap of the correlation matrix for selected genes
heatmap(as.matrix(corr[genes.list, ]))

# Generate a customized color palette for heatmap
Colors <- c("blue", "white", "red")
Colors <- colorRampPalette(Colors)(100)

# Create a heatmap using gplots package
heatmap.2(t(as.matrix(data[genes.list, ])),
          col = Colors, scale = "row", trace = "none", cexCol = 1,
          dendrogram = 'none', Rowv = TRUE, Colv = TRUE, key = FALSE, margins = c(4, 12),
          lmat = rbind(c(2), c(3), c(1), c(2)),
          lhei = c(0.1, 0.1, 5, 0.1), lwid = c(2))

# Write the complete correlation matrix to a file
write.table(corr, file = "cormatrix.txt", sep = "\t")

# Create a heatmap for filtered correlations
filtered_matrix <- as.matrix(corr[(abs(corr$FGF19) > 0.4 & abs(corr$FGFR4) > 0.6), ])
heatmap(filtered_matrix)

# Create a scatterplot between specific genes
plot(t(data["FGFR4", ]), t(data["OXER1", ]))
