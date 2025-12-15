#!/usr/bin/env Rscript
# Minimal PCA plotter for RNA-seq count matrices (CSV) using log2(CPM+1).
# Works with either:
#   - counts.csv (name + sample columns)
#   - a results CSV (e.g., edger.csv) as long as it contains the sample columns

args <- commandArgs(trailingOnly = TRUE)

get_arg <- function(flags, default=NULL) {
  for (f in flags) {
    i <- match(f, args)
    if (!is.na(i) && i < length(args)) return(args[[i+1]])
  }
  return(default)
}
has_flag <- function(flag) any(args == flag)

counts_file <- get_arg(c("-c","--counts"))
design_file <- get_arg(c("-d","--design"))
out_file    <- get_arg(c("-o","--out"), "pca.pdf")
min_total   <- as.numeric(get_arg(c("--min-total"), "10"))

if (is.null(counts_file) || is.null(design_file)) {
  cat("Usage: plot_pca.R -c <counts_or_results.csv> -d <design.csv> -o <pca.pdf> [--min-total 10]\n", file=stderr())
  quit(status=2)
}

# Read inputs
x <- read.csv(counts_file, check.names=FALSE, stringsAsFactors=FALSE)
d <- read.csv(design_file, stringsAsFactors=FALSE)

if (!all(c("sample","group") %in% names(d))) {
  cat("ERROR: design.csv must contain columns: sample,group\n", file=stderr())
  quit(status=2)
}

# Identify ID col and sample columns by intersection with design samples
id_col <- if ("name" %in% names(x)) "name" else names(x)[1]
samples <- d$sample
sample_cols <- intersect(names(x), samples)

if (length(sample_cols) < 2) {
  cat("ERROR: Could not find >=2 sample columns in counts/results file matching design.csv sample names.\n", file=stderr())
  cat("Design samples: ", paste(samples, collapse=", "), "\n", sep="", file=stderr())
  cat("File columns:  ", paste(names(x), collapse=", "), "\n", sep="", file=stderr())
  quit(status=2)
}

# Make matrix (genes x samples)
mat <- as.matrix(x[, sample_cols, drop=FALSE])
mode(mat) <- "numeric"
rownames(mat) <- x[[id_col]]

# Filter low-information rows
keep <- rowSums(mat, na.rm=TRUE) >= min_total
mat <- mat[keep, , drop=FALSE]

# CPM + log transform
lib <- colSums(mat, na.rm=TRUE)
lib[lib == 0] <- NA
cpm <- sweep(mat, 2, lib, "/") * 1e6
cpm[is.na(cpm)] <- 0
logcpm <- log2(cpm + 1)

# PCA
pc <- prcomp(t(logcpm), center=TRUE, scale.=FALSE)
var <- (pc$sdev^2) / sum(pc$sdev^2) * 100

# Colors by group
d2 <- d[match(colnames(logcpm), d$sample), , drop=FALSE]
groups <- as.factor(d2$group)
cols <- as.integer(groups)

pdf(out_file, width=7, height=5)
plot(pc$x[,1], pc$x[,2],
     xlab=sprintf("PC1 (%.1f%%)", var[1]),
     ylab=sprintf("PC2 (%.1f%%)", var[2]),
     pch=19, col=cols,
     main="PCA on log2(CPM + 1)")
text(pc$x[,1], pc$x[,2], labels=colnames(logcpm), pos=4, cex=0.8)
legend("topright", legend=levels(groups), col=seq_along(levels(groups)), pch=19, bty="n", title="Group")
dev.off()

cat("PCA plot: ", out_file, "\n", sep="")
