#!/usr/bin/env Rscript
# Minimal heatmap plotter for RNA-seq count matrices (CSV) using z-scores per gene.
# Works with counts.csv or results files that include the sample columns.

args <- commandArgs(trailingOnly = TRUE)

get_arg <- function(flags, default=NULL) {
  for (f in flags) {
    i <- match(f, args)
    if (!is.na(i) && i < length(args)) return(args[[i+1]])
  }
  return(default)
}

counts_file <- get_arg(c("-c","--counts"))
design_file <- get_arg(c("-d","--design"))
out_file    <- get_arg(c("-o","--out"), "heatmap.pdf")
min_total   <- as.numeric(get_arg(c("--min-total"), "10"))
top_n       <- as.integer(get_arg(c("--top"), "50"))

if (is.null(counts_file) || is.null(design_file)) {
  cat("Usage: plot_heatmap.R -c <counts_or_results.csv> -d <design.csv> -o <heatmap.pdf> [--top 50] [--min-total 10]\n", file=stderr())
  quit(status=2)
}

x <- read.csv(counts_file, check.names=FALSE, stringsAsFactors=FALSE)
d <- read.csv(design_file, stringsAsFactors=FALSE)

if (!all(c("sample","group") %in% names(d))) {
  cat("ERROR: design.csv must contain columns: sample,group\n", file=stderr())
  quit(status=2)
}

id_col <- if ("name" %in% names(x)) "name" else names(x)[1]
samples <- d$sample
sample_cols <- intersect(names(x), samples)

if (length(sample_cols) < 2) {
  cat("ERROR: Could not find >=2 sample columns in counts/results file matching design.csv sample names.\n", file=stderr())
  quit(status=2)
}

mat <- as.matrix(x[, sample_cols, drop=FALSE])
mode(mat) <- "numeric"
rownames(mat) <- x[[id_col]]

keep <- rowSums(mat, na.rm=TRUE) >= min_total
mat <- mat[keep, , drop=FALSE]

# CPM + log2
lib <- colSums(mat, na.rm=TRUE)
lib[lib == 0] <- NA
cpm <- sweep(mat, 2, lib, "/") * 1e6
cpm[is.na(cpm)] <- 0
logcpm <- log2(cpm + 1)

# Pick top variable genes
vars <- apply(logcpm, 1, var, na.rm=TRUE)
ord <- order(vars, decreasing=TRUE)
top_n <- min(top_n, nrow(logcpm))
logcpm <- logcpm[ord[seq_len(top_n)], , drop=FALSE]

# Z-score per gene (row)
z <- t(apply(logcpm, 1, function(v) {
  s <- sd(v, na.rm=TRUE)
  if (is.na(s) || s == 0) return(rep(0, length(v)))
  (v - mean(v, na.rm=TRUE)) / s
}))
rownames(z) <- rownames(logcpm)
colnames(z) <- colnames(logcpm)

# Order samples by group then name (helps readability)
d2 <- d[match(colnames(z), d$sample), , drop=FALSE]
o <- order(d2$group, d2$sample)
z <- z[, o, drop=FALSE]
d2 <- d2[o, , drop=FALSE]

pal <- colorRampPalette(c("green", "black", "red"))(101)

pdf(out_file, width=8, height=8)
heatmap(z,
        Colv=NA, # keep sample ordering (group-sorted)
        scale="none",
        col=pal,
        margins=c(10, 10),
        main=sprintf("Top %d variable genes (z-scores)", top_n))
legend("topright", legend=unique(d2$group), bty="n")
dev.off()

cat("Heatmap: ", out_file, "\n", sep="")
