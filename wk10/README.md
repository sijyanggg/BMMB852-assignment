# Week10 Assignment
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
| annotaiton | Get the annotations of reference genome  |
| vcf | Call SNPs and generate a compressed, indexed VCF file |
| vep | VEP is installed in the environment called vep |

### Input variables
```
# NCBI Genome accession number  
ACC=NC_002549.1
ACC_ANNOTATION=GCF_000848505.1

# Project Name
BIOPROJECT=PRJNA257197

# The user-friendly name for the genome
SAMPLE=ebola

# SRR number
SRR=SRR1553500
```

## Using GNU parallel run the Makefile for two samples.
### Download reference genome and index.
```
make ref SAMPLE=ebola ACC=NC_002549.1 ACC_ANNOTATION=GCF_000848505.1 BIOPROJECT=PRJNA257197
```

### Real processing
Generate results
```
cat design.csv | head -n 3 | \
    parallel --colsep , --header : --eta --lb -j 4 \
        make \
        SRR={Run} \
        readparallel
```



