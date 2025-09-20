# Week4 Assignment
assigned Ebola paper
## Identify the accession numbers for the genome and write the commands to download the data.
The sequence data is under NCBI BioGroup: PRJNA257197 where the accesssion number is GCF_000848505.1 

Input
```
datasets summary genome accession GCF_000848505.1 | jq
datasets download genome accession GCF_000848505.1 --include genome,gff3,gtf
unzip -n ncbi_dataset.zip
cd ncbi_dataset/data/GCF_000848505.1
ls -l
```
Output
```
total 96
-rw-------  1 sijia  staff    19K Sep 20 10:10 GCF_000848505.1_ViralProj14703_genomic.fna
-rw-------  1 sijia  staff    11K Sep 20 10:10 genomic.gff
-rw-------  1 sijia  staff    15K Sep 20 10:10 genomic.gtf
(bioinfo) 
```
## Visualization the genome and the annotations relative to the genome by IGV
