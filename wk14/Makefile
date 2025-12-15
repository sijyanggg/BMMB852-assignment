########################################
# RNA-Seq with HISAT2: UHR/HBR chr22
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
BW_FILES  = $(patsubst %, $(BAMDIR)/%.bw,  $(SAMPLES))

COUNTS    = counts.txt

.PHONY: all index bam bw counts design clean

########################################
# Default target: full pipeline
########################################
all: index $(BAM_FILES) $(BW_FILES) $(COUNTS)

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
# Pattern rule:
#   reads/HBR_1_R1.fq → bam/HBR_1.bam, etc.
$(BAMDIR)/%.bam: $(READSDIR)/%_R1.fq $(IDX).1.ht2
	@mkdir -p $(BAMDIR)
	@echo ">>> Aligning $<"
	hisat2 -x $(IDX) -U $< -S $(BAMDIR)/$*.sam 2> $(BAMDIR)/$*.hisat2.log
	@echo ">>> Sorting BAM for $*"
	samtools sort -o $@ $(BAMDIR)/$*.sam
	samtools index $@
	rm $(BAMDIR)/$*.sam

########################################
# Step 3: create FASTA index for BigWig
########################################
$(REF).fai: $(REF)
	@echo ">>> Indexing reference FASTA for BigWig"
	samtools faidx $<

########################################
# Step 4: BAM -> BigWig coverage
########################################
# Requires: bedtools, bedGraphToBigWig, and REF.fai
$(BAMDIR)/%.bw: $(BAMDIR)/%.bam $(REF).fai
	@echo ">>> Creating BigWig for $*"
	bedtools genomecov -ibam $< -split -bg \
	| sort -k1,1 -k2,2n \
	> $(BAMDIR)/$*.bedgraph
	bedGraphToBigWig $(BAMDIR)/$*.bedgraph $(REF).fai $@
	rm $(BAMDIR)/$*.bedgraph

########################################
# Step 5: featureCounts - gene-level counts
########################################
$(COUNTS): $(BAM_FILES) $(GTF)
	@echo ">>> Running featureCounts on all samples"
	featureCounts -a $(GTF) -o $@ $(BAM_FILES)

########################################
# Optional: create a design file
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
# Cleanup
########################################
clean:
	rm -rf $(BAMDIR) $(COUNTS) design.csv
