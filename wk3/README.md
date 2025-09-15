# Week3 Assignment
## Select a bacteria. Download and unzip the ensemblgenomes
### Fasta
Input
```
micromamba activate bioinfo
wget https://ftp.ensemblgenomes.ebi.ac.uk/pub/bacteria/current/fasta/bacteria_0_collection/bifidobacterium_longum_ncc2705_gca_000007525/dna/Bifidobacterium_longum_ncc2705_gca_000007525.ASM752v1.dna.toplevel.fa.gz
gunzip Bifidobacterium_longum_ncc2705_gca_000007525.ASM752v1.dna.toplevel.fa.gz
mv Bifidobacterium_longum_ncc2705_gca_000007525.ASM752v1.dna.toplevel.fa Bif_l.fa
```
### GFF
Input
```
wget https://ftp.ensemblgenomes.ebi.ac.uk/pub/bacteria/current/gff3/bacteria_0_collection/bifidobacterium_longum_ncc2705_gca_000007525/Bifidobacterium_longum_ncc2705_gca_000007525.ASM752v1.62.gff3.gz
gunzip Bifidobacterium_longum_ncc2705_gca_000007525.ASM752v1.62.gff3.gz
mv Bifidobacterium_longum_ncc2705_gca_000007525.ASM752v1.62.gff3 Bif_l.gff3
```
## Genome Size
Input
```
seqkit stats Bif_l.fa
```
Output
```
file      format  type  num_seqs    sum_len  min_len    avg_len    max_len
Bif_l.fa  FASTA   DNA          2  2,260,266    3,626  1,130,133  2,256,640
```
There are two chromosomes in the file. Total bp in all sequences combined is 2,260,266.
## Features of each type in GFF
Input
```
cat Bif_l.gff3 | grep -v "^#" | cut -f3 | sort | uniq -c | sort -nr
```
Output
```
1799 exon
1729 mRNA
1729 gene
1729 CDS
  69 ncRNA_gene
  56 tRNA
  47 biological_region
  12 rRNA
   1 tmRNA
   1 region
   1 pseudogenic_transcript
   1 pseudogene
   1 chromosome
```
## Separate the intervals of type "gene" or "transcript" into a different file
Input
```
cat Bif_l.gff3 | grep -E "^#|\tgene\t" > gene_only.gff3
cat Bif_l.gff3 | grep -E "^#|\tmRNA\t" > transcript_only.gff3
```
## Visualize and compare the visualization of the original GFF with the simplified GFF.
By comparing the original and simplified GFF, only genes are included in the gene file and mRNA in the trascript file. There are some other biological regions are not included in the simplified GFF. 
<img width="1137" height="697" alt="Screenshot 2025-09-14 at 21 12 40" src="https://github.com/user-attachments/assets/1a22fe05-810d-4d9c-a9e7-0a2f773cd691" />
## Zoom in the sequence with start and stop codon
This zoom-in figure shows the stop codon 'TGA' of gene: BL0240 and start condon 'ATG' of gene: BL0241. This start codon and stop codon share the same TG.
<img width="1135" height="683" alt="Screenshot 2025-09-14 at 21 17 12" src="https://github.com/user-attachments/assets/e14df727-6b38-4af6-ab0f-a2c6a0bd02b8" />
This zoom-in figure shows the stop codon 'TAA' of gene: BL0241. So the gene BL0241 start with ATG and end with TAA.
<img width="1137" height="697" alt="Screenshot 2025-09-14 at 21 19 13" src="https://github.com/user-attachments/assets/95c94c68-76e2-4bfa-816a-9f5a337b6f0e" />

