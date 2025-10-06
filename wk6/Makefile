# Setting defaults
SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Variable
#Reference genome accession
ACC=AF086833.2

# Name
NAME=Ebola_virus

# SRR number
SRR=SRR1972976

# NCBI Genome accession number =AF086833

# Reference genome
REF=refs/${NAME}.fa

# Read 1
R1=reads/${SRR}_1.fastq

# Read 2
R2=reads/${SRR}_2.fastq

# BAM file
BAM=bam/${SRR}.bam

# How many reads to download
N=10000

# Prints the usage message
usage:
@echo "#"
@echo "# Usage: make [all|refs|fastq|index|align|clean]"    
@echo "#"

# -------------No Change Below This Line-------------------

# Obtain the reference genome
get_genome:
# Create the reference directory
# I am extracting the directory name from the path
mkdir -p $(dir ${REF})

# Download the reference genome
bio fetch ${ACC} --format fasta > ${REF}

# Show some information about the genome
seqkit stats ${REF}



# Download a subset of reads from SRA
fastq:
# Obtain run metadata based on SRR number
	 # Create the reads directory
    mkdir -p $(dir ${R1})

    # Download the reads
    fastq-dump -X ${N} --outdir reads --split-files ${SRR}

    # Show some information about the reads
    seqkit stats ${R1} ${R2}

index:
	# Index the reference genome
	 bwa index ${REF}
align:
	# Make the BAM directory
    mkdir -p $(dir ${BAM})

    # Align the reads
    bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM}

    # Index the BAM file
    samtools index ${BAM}

# Generate alignment statistics
stats:
    samtools flagstat ${BAM}

# Clean up generated files
clean:
    rm -rf ${REF} ${R1} ${R2} ${BAM} ${BAM}.bai
# Create necessary directories
all: refs fastq index align stats

# Create necessary directories
.PHONY: all refs fastq index align clean stats

