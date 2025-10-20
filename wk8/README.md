# Week8 Assignment
## Create a design.csv file that connects the SRR numbers to the sample names.
```
esearch -db sra -query PRJNA257197 | efetch -format runinfo > metadata.csv
csvcut -c Run,Sample,BioProject metadata.csv > design.csv
```
## Guideline for Makefile

