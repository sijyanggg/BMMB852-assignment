# ----------------Variables------------------

# Set the URL of the reference genome
REF_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/references/GRCh38/GRCh38_GIABv3_no_alt_analysis_set_maskedGRC_decoys_MAP2K3_KMT2C_KCNJ18.fasta.gz

# Download the reference genome
REF=refs/GRCh38.fasta.gz

# The chromosome of interest.
CHR=chr9

# A subset of the reference genome for the region of interest.
REF=refs/${CHR}.fasta

# get alignments
# Set the URL of the BAM file
BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-N-D_Element-StdInsert_77x_GRCh38-GIABv3.bam

# sequencing technologies
SEQTECH=CDKN2A

# The BAM file name.
BAM=bam/${SEQTECH}.bam

# Set the region of interest.
REGION=chr9:21,967,752-21,995,324

# The temporary bedgraph file
BG=bam/${SEQTECH}.bedgraph

# The BW wiggle file
BW=bam/${SEQTECH}.bw

#----------------Do not change below--------------------------
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
	@echo "# Usage: make [all|refs|fastq|fastqc|index|align|stats|wiggle|vcf|snpeff|clean]"    
	@echo "#"
	@echo "# ACC=${ACC}"
	@echo "# SRR=${SRR}"    
	@echo "# SAMPLE=${SAMPLE}"
	@echo "# BAM=${BAM}"
	@echo "# VCF=${VCF}"
	@echo "#"
	@echo "# "
	@echo "#"


# Get reference genome
ref:
	# Create the reference directory
	mkdir -p refs

	# Download the reference genome
	curl -L ${REF_URL} > ${REF}

	# Show some information about the genome
	seqkit stats ${REF}

align:
	# Create the BAM directory
	mkdir -p bam

	# Extract the reads for the region of interest.
	samtools view -b ${BAM_URL} ${REGION} > ${BAM}

	# Index the BAM file.
	samtools index ${BAM}

	# Get statistics on the BAM file.
	mkdir -p stats
	samtools flagstat ${BAM} > stats/${SEQTECH}_flagstat.txt
	cat stats/${SEQTECH}_flagstat.txt

	# Turn a BAM file into a bigWig file
	# Index the reference genome for use with samtools.
	samtools faidx ${REF}

	# Generate the temporary bedgraph file.
	LC_ALL=C; bedtools genomecov -ibam  ${BAM} -split -bg | \
		sort -k1,1 -k2,2n > ${BG}

	# Convert the bedgraph file to bigwig.
	bedGraphToBigWig ${BG} ${REF}.fai ${BW}

clean:
	rm -rf ${REF} ${BAM} $ ${BAM}.bai

# Create necessary directories
.PHONY: ref align clean