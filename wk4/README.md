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
Load Genome from GCF_000848505.1_ViralProj14703_genomic.fna

Load file from genomic.gff

<img width="1147" height="783" alt="Screenshot 2025-09-20 at 11 35 12" src="https://github.com/user-attachments/assets/1339d816-6a7a-4b76-aa61-f4080a631e64" />

## Evaluating the Genome
### Size
The size of genome is 18,959.

Input
```
seqkit stats GCF_000848505.1_ViralProj14703_genomic.fna
```
Output
```
file                                        format  type  num_seqs  sum_len  min_len  avg_len  max_len
GCF_000848505.1_ViralProj14703_genomic.fna  FASTA   DNA          1   18,959   18,959   18,959   18,959
(bioinfo)
```
### Number of freatures of each type in GFF file
Input
```
cat genomic.gff | grep -v "^#" | cut -f3 | sort | uniq -c | sort -n
```
Output
```
   1 five_prime_UTR
   1 region
   1 three_prime_UTR
   4 sequence_feature
   7 exon
   7 gene
   7 mRNA
   8 polyA_signal_sequence
   8 regulatory_region
```
### The longest gene and its name and function
The longest gene has length of 6782 bp. The gene name is L gene of Ebola virus (a.k.a ZEBOVgp7) which is the gene locus tag for the L gene. It encodes the RNA-dependent RNA polymerase of the Zaire ebolavirus.

Input
```
awk '$3=="gene"{print $5-$4+1, $0}' genomic.gff | sort -k1,1nr | head -1
```
Output
```
6782 NC_002549.1	RefSeq	gene	11501	18282	.	+	.	ID=gene-ZEBOVgp7;Dbxref=GeneID:911824;Name=L;gbkey=Gene;gene=L;gene_biotype=protein_coding;locus_tag=ZEBOVgp7
(bioinfo)
```
### Other gene names
Input
```
awk '$3=="gene"{print $9}' genomic.gff
```
Output
```
ID=gene-ZEBOVgp1;Dbxref=GeneID:911830;Name=NP;gbkey=Gene;gene=NP;gene_biotype=protein_coding;locus_tag=ZEBOVgp1
ID=gene-ZEBOVgp2;Dbxref=GeneID:911827;Name=VP35;gbkey=Gene;gene=VP35;gene_biotype=protein_coding;locus_tag=ZEBOVgp2
ID=gene-ZEBOVgp3;Dbxref=GeneID:911825;Name=VP40;gbkey=Gene;gene=VP40;gene_biotype=protein_coding;locus_tag=ZEBOVgp3
ID=gene-ZEBOVgp4;Dbxref=GeneID:911829;Name=GP;gbkey=Gene;gene=GP;gene_biotype=protein_coding;locus_tag=ZEBOVgp4
ID=gene-ZEBOVgp5;Dbxref=GeneID:911826;Name=VP30;gbkey=Gene;gene=VP30;gene_biotype=protein_coding;locus_tag=ZEBOVgp5
ID=gene-ZEBOVgp6;Dbxref=GeneID:911828;Name=VP24;Note=putative;gbkey=Gene;gene=VP24;gene_biotype=protein_coding;locus_tag=ZEBOVgp6
ID=gene-ZEBOVgp7;Dbxref=GeneID:911824;Name=L;gbkey=Gene;gene=L;gene_biotype=protein_coding;locus_tag=ZEBOVgp7
(bioinfo)
```
### Another gene and its name and function
Another gene in Ebola virus is VP40. Ebola VP40 is Ebola virus matrix protein which is crucial for virus assembly, budding, and release from host cells. It forms a shell under the viral lipid membrane, acting as a key structural component in the production of new Ebola virions and is essential for the formation of virus-like particles (VLPs). Its funcion involves dynamic structural changes. 




