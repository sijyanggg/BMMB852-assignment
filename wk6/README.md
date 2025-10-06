# Week 6 Assigment
## Guideline of Makefile
Get the reference genome
```
make refs
```
Download a subset of reads from SRA
```
make fastq
```
Index the reference genome
```
make index
```
Generate a sorted and indexed BAM file by aligning reads to the genome
```
make align
```
Generate alignment statistics
```
make stats
```
Automatically generate all files for genome alignment 
```
make all
```
## Visualization of resulting files for both simulated reads and reads downloaded from SRA.
<img width="1135" height="375" alt="Screenshot 2025-10-05 at 23 11 30" src="https://github.com/user-attachments/assets/3bffeecd-ae15-412a-8e46-707c8de4c99e" />

## Alignment statistics for the BAM file

input
```
make stats
```
output
```
samtools flagstat bam/SRR1972975.bam
20005 + 0 in total (QC-passed reads + QC-failed reads)
20000 + 0 primary
0 + 0 secondary
5 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
60 + 0 mapped (0.30% : N/A)
55 + 0 primary mapped (0.27% : N/A)
20000 + 0 paired in sequencing
10000 + 0 read1
10000 + 0 read2
48 + 0 properly paired (0.24% : N/A)
52 + 0 with itself and mate mapped
3 + 0 singletons (0.02% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
(bioinfo) 
```
### Percentage of reads aligned to the genome
60 are mapped with 0.30% reads aligned to the genome. 0.27% are primary mapped and 0.24% are properly paired.
### Expected average coverage
The genome length is 18959 bp. There are 20000 of reafs so the coverage is expected to be 20,000X100/18959 = 105.5x for 100 bp reads or 20,000X150/18959 = 158.2x for 150 bp reads.
### Observed average coverage
Observed coverage is 60X100/18959 = 0.32X for 100 bp reads or 60X150/18959 = 0.47X for 150 bp reads.
### How much does the coverage vary across the genome? (Provide a visual estimate.)
Based on IGV, most of the genome has no coverage to the SRR1972975. Only few scattered region is mapped. 



