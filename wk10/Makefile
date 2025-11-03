#
# Makefile for aligning short reads with BWA
#

# NCBI Genome accession number  
ACC=NC_002549.1
ACC_ANNOTATION=GCF_000848505.1

# Project Name
BIOPROJECT=PRJNA257197

# The user-friendly name for the genome
SAMPLE=ebola

# SRR number
SRR ?=SRR1553500

# Reference genome
REF=refs/${SAMPLE}.fa

# The GFF file.
GFF=refs/genomic.gff

# Read 1
R1=reads/${SRR}_1.fastq

# Read 2
R2=reads/${SRR}_2.fastq

# BAM file
BAM=bam/${SRR}.bam

# The temporary bedgraph file
BG=bam/${SRR}.bedgraph

# The BW wiggle file
BW=bam/${SRR}.bw

# The resulting variant VCF file (compressed!).
VCF=vcf/${SRR}.vcf.gz

# How many reads to download
N=10000

# Directory for quality control results
FASTQC_DIR = results/fastqc

# Input FASTQ files (adjust pattern as needed)
FASTQ_FILES = $(wildcard data/*.fastq.gz)

# Create output file names for all FASTQ inputs
FASTQC_RESULTS = $(FASTQ_FILES:data/%.fastq.gz=$(FASTQC_DIR)/%.html)

# Setting useful defaults.
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Prints the usage message
usage:
	@echo "#"
	@echo "# Usage: make [all|refs|fastq|fastqc|index|align|stats|wiggle|vcf|vep|clean]"    
	@echo "#"
	@echo "# ACC=${ACC}"
	@echo "# SRR=${SRR}"    
	@echo "# SAMPLE=${SAMPLE}"
	@echo "# BAM=${BAM}"
	@echo "# VCF=${VCF}"
	@echo "#"
	@echo "# "
	@echo "#"

# Check that the bio toolbox is installed.
CHECK_FILE = src/run/genbank.mk
${CHECK_FILE}:
	@echo "#"
	@echo "# Please install toolbox with: bio code"
	@echo "#"
	@exit 1

# Obtain the reference genome
refs:
	# Create the reference directory
	# I am extracting the directory name from the path
	mkdir -p $(dir ${REF})

	# Download the reference genome
	bio fetch ${ACC} --format fasta > ${REF}

	# Show some information about the genome
	seqkit stats ${REF}

	echo "refernce genome downloaded"

# Get the annotations of reference genome 
annotations:
	datasets download genome accession "${ACC_ANNOTATION}" --include genome,gff3,gtf
	unzip -n ncbi_dataset.zip
	mv ncbi_dataset/data/GCF_000848505.1/genomic.gff refs/genomic.gff



# Download a subset of reads from SRA
# Remove the -X flag to get all data.
fastq: 
	# Create the reads directory
	mkdir -p $(dir ${R1})

	# Download the reads
	fastq-dump -X ${N} --outdir reads --split-files ${SRR}

	# Show some information about the reads
	# seqkit stats ${R1} ${R2}
	@if [ -f reads/$(SRR)_2.fastq ]; then 
		seqkit stats ${R1} ${R2}; 
	else 
		seqkit stats ${R1}; 
	fi

# Generate FASTQC reports for each read
fastqc: $(FASTQC_RESULTS)
	mkdir -p $(FASTQC_DIR)
	fastqc -o $(FASTQC_DIR) ${R1} ${R2}


# Index the reference genome
index:
	bwa index ${REF}

# Align the reads and convert to BAM. Use 4 threads
# Works for paired-end reads. Modify for single-end reads.
align:
	# Make the BAM directory
	mkdir -p $(dir ${BAM})

	# Align the reads
	# bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM}
	@if [ -f reads/$(SRR)_2.fastq ]; then \
		bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM}; 
	else 
		minimap2 -t 4 -ax map-ont ${REF} ${R1} | \
		 samtools view -b - | \
		 samtools sort -@ 4 -o bam/ERR1248107.bam; \
	fi

	# Index the BAM file
	samtools index ${BAM}

# Call the SNPs in the resulting BAM file.
# Call SNPs and generate a compressed, indexed VCF file
vcf: $(BAM)
	# Create the VCF directory if needed
	mkdir -p $(dir ${VCF})

	# Generate variant calls using bcftools
	bcftools mpileup -Ou -f ${REF} ${BAM} | \
		bcftools call -mv -Oz -o ${VCF}

	# Index the resulting VCF file
	bcftools index ${VCF}

	# Display summary information
	echo "VCF file created: ${VCF}"
	bcftools stats ${VCF} | head -20


# Generate alignment statistics
stats:
	# Make the stats directory
	samtools flagstat ${BAM}

# Turn a BAM file into a bigWig file
wiggle: 
	# Index the reference genome
	samtools faidx ${REF}

	# Generate the temporary bedgraph file.
	LC_ALL=C; bedtools genomecov -ibam  ${BAM} -split -bg | \
		sort -k1,1 -k2,2n > ${BG}

	# Convert the bedgraph file to bigwig.
	bedGraphToBigWig ${BG} ${REF}.fai ${BW}

# Clean up generated files
clean:
	rm -rf ${REF} ${R1} ${R2} ${BAM} $(FASTQC_DIR) ${BAM}.bai

# VEP needs a sorted and compressed GFF file.
${GFF}.gz:
	# Sort and compress the GFF file
	# Needs the double $ to pass the $ from make to bash
	cat ${GFF} | sort -k1,1 -k4,4n -k5,5n -t$$'\t' | bgzip -c > ${GFF}.gz

	# Index the GFF file
	tabix -p gff ${GFF}.gz

# VEP is installed in the environment called vep
vep: ${GFF}.gz
	mkdir -p results
	micromamba run -n vep \
		~/src/ensembl-vep/vep \
		-i ${VCF} \
		-o results/vep.txt \
		--gff ${GFF}.gz \
		--fasta ${REF} \
		--force_overwrite 

    # Show the resulting files
	ls -lh results/*

# Run all
all: refs fastq fastqc index align stats wiggle vcf vep 

# Run parallel reads
readparallel: fastq fastqc align stats wiggle vcf vep

# Obtain ref genome and index
ref: refs index annotations

# Create necessary directories
.PHONY: all refs fastq fastqc index align clean stats vep

