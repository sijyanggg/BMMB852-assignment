# Week7 Assignment
## Guideline of Makefile with sample of Ebola virus and SRR1553500 
### Automatically generate all files for genome alignment with SRR1553500
```
# Run under bioinfo enviroment
micromamba activate bioinfo
# Automatically generate all files
make all ACC=NC_002549.1 NAME=ebola SRR=SRR1553500
```
### Step by step generating all files with SRR1553500
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
```
## Datasets and Visulization in IGV
### Project Accession: PRJNA257197
Zaire ebolavirus genome sequencing from 2014 outbreak in Sierra Leone: 
SRR1553500
<img width="1150" height="764" alt="Screenshot 2025-10-12 at 23 41 36" src="https://github.com/user-attachments/assets/8fbf4797-91fa-4b5c-9211-511174c93182" />

### Project Accession: PRJEB10571
MinION sequencing; Ebola virus surveillance with portable nanopore sequencing: 
ERR1248107

<img width="1151" height="761" alt="Screenshot 2025-10-12 at 23 40 55" src="https://github.com/user-attachments/assets/e178608e-60c4-44bc-ac7f-ca92d0b7623d" />

### Questions and Answers
## Briefly describe the differences between the alignment in both files.
SRR1553500 (Illumina) has senven genome-wide coverage, tight piles and few indels. Those are typical short-read shotgun alignment.
ERR1248107 (Nanopore) has spiky/tiling coverage with dropouts, chunkier reads, many small indels. Those are typical ONT amplicon data.
## Briefly compare the statistics for the two BAM files.
SRR1553500, the Illumina paired-end, has ~20.9k reads with 20k primary. It has an excellent 98.6% mapping rate and ~98% properly paired with only 9 singletons and ~4% supplementary. Those are hallmarks of a clean PE library. ERR1248107, the ONT/MinION single-end, is smaller with ~4.4k reads and 4.3k primary. It has an 87.2% mapping rate , no pairing metrics by design, and ~2.3% supplementary. Overall, the Illumina BAM yields many more reads and higher mapping/pairing quality, while the ONT BAM shows the expected lower mapping rate for long reads but still reasonable alignment quality.


Output for SRR1553500
```
20861 + 0 in total (QC-passed reads + QC-failed reads)
20000 + 0 primary
0 + 0 secondary
861 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
20578 + 0 mapped (98.64% : N/A)
19717 + 0 primary mapped (98.58% : N/A)
20000 + 0 paired in sequencing
10000 + 0 read1
10000 + 0 read2
19592 + 0 properly paired (97.96% : N/A)
19708 + 0 with itself and mate mapped
9 + 0 singletons (0.04% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```
Output for ERR1248107
```
4438 + 0 in total (QC-passed reads + QC-failed reads)
4338 + 0 primary
0 + 0 secondary
100 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
3870 + 0 mapped (87.20% : N/A)
3770 + 0 primary mapped (86.91% : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```
## How many primary alignments does each of your BAM files contain?
The SRR1553500 has 20,000 of primary alignments and the ERR1248107 has 4,338.
## What coordinate has the largest observed coverage (hint samtools depth)
ERR1248107 with depth 1056 has the largest comparing to SRR1553500 with depth 186

Input
```
samtools depth -a SRR1553500.bam | sort -k3,3nr | head -1
```
Output
```
NC_002549.1	5608	186
```
Input
```
samtools depth -a ERR1248107.bam | sort -k3,3nr | head -1
```
Output
```
NC_002549.1	17601	1056
```
## Select a gene of interest. How many alignments on a forward strand cover the gene?
Gene: GP
Alignment for SRR1553500 are 1343 and alignments for ERR1248107 are 170.
Input
```
REGION=$(echo 'NC_002549.1:6,037-8,065' | tr -d ',')
echo "$REGION"   # -> NC_002549.1:5265-8515
samtools view -c -F 2324 bam/SRR1553500.bam "$REGION"
samtools view -c -F 2324 bam/ERR1248107.bam "$REGION"
```
<img width="1055" height="746" alt="Screenshot 2025-10-13 at 00 26 29" src="https://github.com/user-attachments/assets/64805e0d-287b-42b1-abd7-cea2544ca76f" />



