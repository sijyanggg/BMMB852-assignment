# Week 11 Assignment
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
| snpeff | Add the snpEff target to VCF |
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
SRR=SRR1972967
```
## Process to generate VCF file and genetic variant annotation, and functional effect prediction toolbox via SnpEff
Toolbox install
```
bio code
```
Download reference genome and index.
```
make ref SAMPLE=ebola ACC=NC_002549.1 ACC_ANNOTATION=GCF_000848505.1 BIOPROJECT=PRJNA257197
```
Generate BAM, VCF and SnpEff files of SRR1972967
```
make readparallel SRR=SRR1972967
```
## Results
### Evaluate the effects of at least three variants via IGV
#### Variant 1-Moderate 
This is a missense variant at position 12,355 in gene L. This variant means the change of A to G lead the amino acid Ile change to Val. This is considered as moderate impact to the genome.

<img width="1139" height="631" alt="Screenshot 2025-11-09 at 22 49 05" src="https://github.com/user-attachments/assets/facce02b-0473-4704-a507-e13057a818f2" />

#### Variant 2-Low 
This is a synonymous variant at position 12,363 in gene L. This variant means the change of T to C lead no effect on aminoacid Asp. This is considered as low impact to the genome.

<img width="1147" height="702" alt="Screenshot 2025-11-09 at 22 58 04" src="https://github.com/user-attachments/assets/82c0d2f1-22ed-49ed-ba18-257b732557e9" />

#### Variant 3-Low 
This is a synonymous variant at position 10,350 in gene VP24. This variant means the change of T to C lead no effect on aminoacid Ala. This is considered as low impact to the genome.

<img width="1132" height="732" alt="Screenshot 2025-11-09 at 23 05 16" src="https://github.com/user-attachments/assets/c5c085b8-34ee-4c0e-97ba-cb086afa1f9a" />


### SnpEff: Variant analysis
The result of SRR1972967 shows 567 variants across an 18,959 bp genome, with no insertions or deletions detected. Major variants are silent with low effect in function, and missense mutations about 23.24% with low effect. The data also show a strong transition bias (Ts/Tv = 5.36). This indicates biological consistency and sequencing reliability. 

<img width="331" height="75" alt="Screenshot 2025-11-09 at 22 37 51" src="https://github.com/user-attachments/assets/99b64c8a-b84b-4fe5-8da2-f1a1d241b011" />

Number variants by type

<img width="133" height="246" alt="Screenshot 2025-11-09 at 22 38 24" src="https://github.com/user-attachments/assets/61c7e1d3-84ea-43f3-ba72-3b7c81383da7" />

Number of effects by functional class

<img width="313" height="85" alt="Screenshot 2025-11-09 at 22 38 53" src="https://github.com/user-attachments/assets/e370310e-8f90-4876-aca0-21d942ee39f9" />

Number of effects by type and region

<img width="822" height="282" alt="Screenshot 2025-11-09 at 22 39 24" src="https://github.com/user-attachments/assets/9fffd34a-e11b-4cf9-ac7c-c79e03e0cf79" />








