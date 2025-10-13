# BMMB852 Assignment
## Guideline of Makefile with sample of Zaire ebolavirus and SRR1553500
### Automatically generate all files for genome alignment of SRR1553500
```
# Run Makefile under bioinfo environment
micromamba activate bioinfo

# Automatically generate all files for genome alignment of SRR1553500
make all ACC=NC_002549.1 NAME=ebola SRR=SRR1553500
```
### Step by step generate all files for genome alignment of SRR1553500
```
# Get the reference genome
make refs ACC=NC_002549.1 NAME=ebola SRR=SRR1553500

# Download a subset of reads from SRA
make fastq ACC=NC_002549.1 NAME=ebola SRR=SRR1553500

# Index the reference genome
make index ACC=NC_002549.1 NAME=ebola SRR=SRR1553500

# Generate a sorted and indexed BAM file by aligning reads to the genome
make align ACC=NC_002549.1 NAME=ebola SRR=SRR1553500

# Generate alignment statistics
make stats ACC=NC_002549.1 NAME=ebola SRR=SRR1553500

# Turn a BAM file into a bigWig file
make wiggle ACC=NC_002549.1 NAME=ebola SRR=SRR1553500

# Clean up generated files
make clean ACC=NC_002549.1 NAME=ebola SRR=SRR1553500
```
## Datasets and Visualization in IGV
### Bioproject Accession:	PRJNA257197
Zaire ebolavirus genome sequencing from 2014 outbreak in Sierra Leone: SRR1553500 by Illumina
<img width="1150" height="764" alt="Screenshot 2025-10-12 at 23 41 36" src="https://github.com/user-attachments/assets/0389e224-d391-4a83-aa14-9d5714232e9f" />


### Bioproject Accession: PRJEB10571
MinION sequencing; Ebola virus surveillance with portable nanopore sequencing: ERR1248107 by OXFORD_NANOPORE
<img width="1151" height="761" alt="Screenshot 2025-10-12 at 23 40 55" src="https://github.com/user-attachments/assets/b0b88e90-e429-4026-bdc9-81e47551fbf8" />

## Answers for Questions
### Differences between the alignment in both files
### Comparing the statistics for the two BAM files
### Number of primary alignments in each BAM file
### Coordinate with the largest observed coverage
### Number of alignments on a forward strand cover the gene
