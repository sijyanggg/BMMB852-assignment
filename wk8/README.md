# Week8 Assignment
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

## Using GNU parallel run the Makefile on all (or at least 10) samples.
### Test with dry-Run
preview commands without executing them
```
cat design.csv | head -n 10 | \
    parallel --dry-run --colsep , --header : --eta --lb -j 4 \
        make \
        SRR = {Run} \
        NAME = ebola \
        BIOPROJECT = {BioProject} \
        ACC = NC_002549.1 \
        all
```
### Real processing
Generate results
```
cat design.csv | head -n 10 | \
    parallel --colsep , --header : --eta --lb -j 4 \
        make \
        SRR={Run} \
        NAME=ebola \
        BIOPROJECT={BioProject} \
        ACC=NC_002549.1 \
        all
```

