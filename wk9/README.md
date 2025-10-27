# Week9 Assignment
## Create a design.csv file that connects the SRR numbers to the sample names.
```
esearch -db sra -query PRJNA257197 | efetch -format runinfo > metadata.csv
csvcut -c Run,Sample,BioProject metadata.csv > design.csv
```
## Guideline for Makefile
| Function | Explanation |
|--------|------|
| refs | Obtain the reference genome |
| fastq | Download a subset of reads from SRA |
| fastqc | Generate FASTQC reports for each read |
| index | Index the reference genome |
| align | Align the reads and convert to BAM |
| stats | Generate alignment statistics | 
| wiggle | Turn a BAM file into a bigWig file |
| clean | Clean up generated files | 
| all | Automatically run all command |
| readparallel | Run individual SRR analysis |
| ref | Obtain ref genome and index |

### Input variables
```
# NCBI Genome accession number  
ACC=NC_002549.1

# Project Name
BIOPROJECT=PRJNA257197

# The user-friendly name for the genome
NAME=ebola

# SRR number
SRR=SRR1553500
```

## Using GNU parallel run the Makefile on all (or at least 10) samples.
### Download reference genome and index.
```
make ref NAME=ebola ACC=NC_002549.1 BIOPROJECT=PRJNA257197
```
### Test with dry-Run
preview commands without executing them
```
cat design.csv | head -n 10 | \
    parallel --dry-run --colsep , --header : --eta --lb -j 4 \
        make \
        SRR={Run} \
        readparallel
```
### Real processing
Generate results
```
cat design.csv | head -n 10 | \
    parallel --colsep , --header : --eta --lb -j 4 \
        make \
        SRR={Run} \
        readparallel
```


