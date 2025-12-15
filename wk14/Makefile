########################################
# RNA-Seq with HISAT2: UHR/HBR chr22
# + Counts -> PCA + Heatmap (R)
########################################

# ---- Reference genome and annotation ----
REF   = refs/chr22.genome.fa
GTF   = refs/chr22.gtf

# HISAT2 index prefix (will produce refs/chr22.*.ht2)
IDX   = refs/chr22

# Samples: 3 HBR (control), 3 UHR (treatment)
SAMPLES = HBR_1 HBR_2 HBR_3 UHR_1 UHR_2 UHR_3

# Directories
READSDIR = reads
BAMDIR   = bam

# Derived file lists
BAM_FILES = $(patsubst %, $(BAMDIR)/%.bam, $(SAMPLES))

# featureCounts output + simplified counts matrix
COUNTS_TXT = counts.txt
COUNTS_CSV = counts.csv

# Plots
EDGER_OUT   = edger.csv
PCA_PDF     = pca.pdf
HEATMAP_PDF = heatmap.pdf

# R helper scripts (provided with this submission)
EDGER_R       = src/r/edger.r
PLOT_PCA_R    = src/r/plot_pca.r
PLOT_HEATMAP_R= src/r/plot_heatmap.r

.PHONY: all index bam counts design qc clean

########################################
# Default: generate counts + design + PCA + heatmap
########################################
all: $(COUNTS_TXT) design.csv $(COUNTS_CSV) qc

########################################
# Step 1: build HISAT2 index
########################################
index: $(IDX).1.ht2

$(IDX).1.ht2: $(REF)
	@echo ">>> Building HISAT2 index for $(REF)"
	hisat2-build $< $(IDX)

########################################
# Step 2: align reads -> sorted BAM
########################################
$(BAMDIR)/%.bam: $(READSDIR)/%_R1.fq $(IDX).1.ht2
	@mkdir -p $(BAMDIR)
	@echo ">>> Aligning $<"
	hisat2 -x $(IDX) -U $< -S $(BAMDIR)/$*.sam 2> $(BAMDIR)/$*.hisat2.log
	@echo ">>> Sorting BAM for $*"
	samtools sort -o $@ $(BAMDIR)/$*.sam
	samtools index $@
	rm $(BAMDIR)/$*.sam

########################################
# Step 3: featureCounts - gene-level counts (tab-delimited)
########################################
counts: $(COUNTS_TXT)

$(COUNTS_TXT): $(BAM_FILES) $(GTF)
	@echo ">>> Running featureCounts on all samples"
	featureCounts -a $(GTF) -o $@ $(BAM_FILES)

########################################
# Step 4: design file (group labels)
########################################
design: design.csv

design.csv:
	@echo "sample,group" > $@
	@echo "HBR_1,HBR"   >> $@
	@echo "HBR_2,HBR"   >> $@
	@echo "HBR_3,HBR"   >> $@
	@echo "UHR_1,UHR"   >> $@
	@echo "UHR_2,UHR"   >> $@
	@echo "UHR_3,UHR"   >> $@
	@echo ">>> Created design.csv"

########################################
# Step 5: Convert featureCounts output -> counts.csv (name + sample columns)
########################################
$(COUNTS_CSV): $(COUNTS_TXT)
	@echo ">>> Converting $(COUNTS_TXT) -> $(COUNTS_CSV)"
	Rscript -e "x <- read.delim('$(COUNTS_TXT)', comment.char='#', check.names=FALSE); samp <- grep('.bam$$', names(x), value=TRUE); out <- x[, c('Geneid', samp)]; names(out)[1] <- 'name'; names(out)[-1] <- sub('.bam$$','', basename(samp)); write.csv(out, '$(COUNTS_CSV)', row.names=FALSE, quote=FALSE)"


########################################
# Step 6: PCA + heatmap from normalized counts
########################################
qc: $(PCA_PDF) $(HEATMAP_PDF)

$(PCA_PDF): $(EDGER_OUT) design.csv 
	@echo ">>> Generating PCA : $(PCA_PDF)"
	Rscript $(PLOT_PCA_R) -c $(EDGER_OUT) -d design.csv -o $(PCA_PDF)

$(HEATMAP_PDF): $(EDGER_OUT) design.csv 
	@echo ">>> Generating heatmap : $(HEATMAP_PDF)"
	Rscript $(PLOT_HEATMAP_R) -c $(EDGER_OUT) -d design.csv -o $(HEATMAP_PDF)

########################################
# Cleanup
########################################
clean:
	rm -rf $(BAMDIR) $(COUNTS_TXT) $(COUNTS_CSV) design.csv $(PCA_PDF) $(HEATMAP_PDF)
