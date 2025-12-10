# Week 13 Assignment
## Data source
Informatics for RNA-seq: A web resource for analysis on the cloud PLoS Computational Biology (2015) by Malachi Griffith, Jason R. Walker, Nicholas C. Spies, Benjamin J. Ainscough, Obi L. Griffith.
## Download Data
```
# Download the data
wget -nc  http://data.biostarhandbook.com/data/uhr-hbr.tar.gz

# Unpack the data
tar xzvf uhr-hbr.tar.gz
```
## Run all workflow
```
make all
```
## Make design file
```
make design
```
## Count matrix summary: read counts for each dataset

Exons always have high alignments which indicates it is RNA-Seq data.

<img width="571" height="482" alt="Screenshot 2025-12-09 at 21 30 14" src="https://github.com/user-attachments/assets/c56dfef9-1d0b-4552-8d02-8a59f06da1b7" />
<img width="571" height="701" alt="Screenshot 2025-12-09 at 21 30 30" src="https://github.com/user-attachments/assets/36fe5bfb-bad1-4662-a4e3-46e57f2cb258" />

## IGV visualization - Example HBR_1 & UHR_1
<img width="1279" height="581" alt="Screenshot 2025-12-09 at 21 35 44" src="https://github.com/user-attachments/assets/9c43fbb3-232d-4ec5-aca9-d759b8d81b8c" />

<img width="1283" height="706" alt="Screenshot 2025-12-09 at 21 39 45" src="https://github.com/user-attachments/assets/048c5d6f-acd8-4bd2-8aff-50e8389d1637" />

## Discussion
From the count matrix, we inspected several genes and found that the numbers agree well with the alignment tracks in IGV. For example, BMS1P22 shows very low counts in all HBR replicates (0–3) but consistently higher counts in UHR (21–22), and in IGV the UHR tracks display strong, continuous coverage over this gene while HBR tracks are almost flat. Genes with uniformly low counts, such as PSLNR, show only a few isolated reads and almost no visible coverage in any track, matching their near-zero values in the matrix. Conversely, genes with similar counts across all six samples show comparable coverage heights in both HBR and UHR tracks, indicating stable expression. Overall, the visual patterns in IGV support that the featureCounts matrix accurately summarizes gene-level read counts.


<img width="1292" height="788" alt="Screenshot 2025-12-09 at 21 49 44" src="https://github.com/user-attachments/assets/7f9b51f5-4a35-476d-a928-1777f9212600" />


