# Week2 Assignment
## Organism Info
Accipiter nisus, also called northern sparrowhawk, is a small bird of prey in the family Accipitridae. Adult male Eurasian sparrowhawks have bluish grey upperparts and orange-barred underparts; females and juveniles are brown above with brown barring below. It is a predator for woodland birds and it also can be found in any habitat and hunts garden birds in towns and cities.
## Download and Decompress 
```
curl -O https://ftp.ensembl.org/pub/release-115/gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3.gz
gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3.gz
```
## Number of sequence regions (chromosomes)
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep "^##sequence-region" | wc -l
```
There are 44975 sequence regions in the file. This number is matched with the number of scaffolds which is 44975 which does not represent the actual chromosomes. Since the genome has not been assembled into full chromosomes.
## Number of features
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | wc -l
```
The number of features in this file is 867929.
## Number of genes
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | awk '$3=="gene"' | wc -l
```
There are 17271 of genes listed for this organism. 
## List all features in the file
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | cut -f3 | sort | uniq
```
Output
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
```
Pseudogenes are nonfunctional segments of DNA that resemble functional genes. They became into an inactive form over the course of evoluation due to mutation. It often lacks introns and other essential DNA sequences necessary for function.

## Top-ten most annotated feature types (column 3) across the genome
```
cat Accipiter_nisus.Accipiter_nisus_ver1.0.115.gff3 | grep -v "^#" | cut -f3 | sort | uniq -c | sort -nr | head -10
```
Output
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
```
## Does it seem like a complete and well-annotated organism?
This is a well-annotated organisms. It includes protein-coding genes, pseudogenes, small RNA as well as lincRNAs with difference source of evidence. However, this is scaffold-level assembly not chromosome-level assembly.
## Other insights
The genome in the file is highly fragmented. It includes different genes which indicates attention to the non-coding and regulatory elements. This file combines multiple data sources which can help improve accuracy of gene models. 
