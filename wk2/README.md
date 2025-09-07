# Week2 Assignment
## Organism Info
Accipiter nisus
## Download and Decompress 
```
curl -O https://ftp.ensembl.org/pub/release-115/gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3.gz
gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3.gz
```
## Number of sequence regions (chromosomes)
44975
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep "^##sequence-region" | wc -l
```
## Number of features
867929
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | wc -l
```
## Number of genes
17271
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | awk '$3=="gene"' | wc -l
```
## List all features in the file
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | cut -f3 | sort | uniq
```
CDS
V_gene_segment
Y_RNA
biological_region
exon
five_prime_UTR
gene
lnc_RNA
mRNA
miRNA
ncRNA_gene
pseudogene
pseudogenic_transcript
rRNA
region
scRNA
snRNA
snoRNA
three_prime_UTR
transcript

## Top-ten most annotated feature types (column 3) across the genome
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | cut -f3 | sort | uniq -c | sort -nr | head -10
```
309995 exon
301420 CDS
133065 biological_region
44975 region
27007 mRNA
18324 five_prime_UTR
17271 gene
14159 three_prime_UTR
 754 ncRNA_gene
 433 lnc_RNA
