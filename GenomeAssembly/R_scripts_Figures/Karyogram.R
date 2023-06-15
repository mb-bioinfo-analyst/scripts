
setwd("..\\karyogram\\")
library(karyoploteR)
library(rtracklayer)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%
library(data.table)

fign="Fig. "
name1="Denovo_Genome_Assembly"
# Load all required files generated from processing the genome assembly
# motif locations
gff.file  <- "Assembly.fasta.AAAAA6.gff"
# Karyotype information for scaffold size
Karyotype <- read.table("Assembly_karyotype.txt", header = TRUE)
# Gap size and locations
NNN       <- read.table("Assembly.fasta.NoEOL.region.N", header = TRUE)
NNN       <- NNN[which(NNN$seqnames %like% 'CM' | NNN$seqnames %like% 'Chr'),]
Ns        <- subset(NNN, NNN$width > 99)

features <- import(gff.file)
genes <- features[features$type=="gene"]
#KaryotypeScale <- data.frame(chr=c("Scale"), start=c(0), end=c(28000000))
#genome <- toGRanges(rbind(KaryotypeScale, Karyotype))
genome <- toGRanges(Karyotype[ which(Karyotype$chr %like% 'CM' | Karyotype$chr %like% 'Chr'),])
labels1 <- paste("N", Ns$width, sep="")
Ns_all <- toGRanges(cbind(subset(Ns, select=c(seqnames, start, end)), labels1))
# motif locations and size 
TTAGG10 <- read.table("Assembly.fasta.AAAAA6.GRanges")
TTAGG10frw <- TTAGG10[TTAGG10[5]=="+", ]
TTAGG10rev <- TTAGG10[TTAGG10[5]=="-", ]

# Set the parameters for plot

plot.params <- getDefaultPlotParams(plot.type=1)
plot.params$ideogramheight <- 15
plot.params$data2height <- 75

# #kp <- plotKaryotype(genome=genome, main=paste(fign, name1, "Karyotype. LiftoffGenes(darkgray) TTAGG10(magenta), CCTAA10(cyan), Ns(red).", sep=" "),  cex=0.8)
# kp <- plotKaryotype(genome=genome, main=paste(fign, name1, "Karyotype. AAAAA6(blue), TTTTT6(cyan), Ns(red).", sep=" "),  cex=0.8)
# kpPlotRegions(kp, data=genome,col="gray", border="white", data.panel="ideogram", avoid.overlapping = FALSE)
# kpPlotRegions(kp, data=genes,      col="#707070", data.panel="ideogram", avoid.overlapping = FALSE)
# kpPlotRegions(kp, data=Ns_all,     col="red",     data.panel="ideogram", avoid.overlapping = FALSE)
# kpPlotRegions(kp, data=TTAGG10frw, col="blue", r0=0, r1=0.2, avoid.overlapping = FALSE)
# kpPlotRegions(kp, data=TTAGG10rev, col="cyan", r0=0, r1=0.2, avoid.overlapping = FALSE)
# kpAddBaseNumbers(kp, tick.dist = 5000000, tick.len = 10, cex=0.6, minor.tick.dist = 500000, minor.tick.len = 5, col="gray")


png("Assembly.fasta.AAAAA6.png", width = 1920, height = 1080, res = 100)
kp <- plotKaryotype(genome=genome, main=paste(fign, name1, "Karyotype. AAAAA6(blue), TTTTT6(cyan), Ns(red).", sep=" "),  cex=0.8)
kpPlotRegions(kp, data=genome,col="gray", border="white", data.panel="ideogram", avoid.overlapping = FALSE)
kpPlotRegions(kp, data=genes,      col="#707070", data.panel="ideogram", avoid.overlapping = FALSE)
kpPlotRegions(kp, data=Ns_all,     col="red",     data.panel="ideogram", avoid.overlapping = FALSE)
kpPlotRegions(kp, data=TTAGG10frw, col="blue", r0=0, r1=0.2, avoid.overlapping = FALSE)
kpPlotRegions(kp, data=TTAGG10rev, col="cyan", r0=0, r1=0.2, avoid.overlapping = FALSE)
kpAddBaseNumbers(kp, tick.dist = 5000000, tick.len = 10, cex=0.6, minor.tick.dist = 500000, minor.tick.len = 5, col="gray")
dev.off()








