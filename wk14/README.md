# Week 14 Assignment
# Previous work
## Data source
Informatics for RNA-seq: A web resource for analysis on the cloud PLoS Computational Biology (2015) by Malachi Griffith, Jason R. Walker, Nicholas C. Spies, Benjamin J. Ainscough, Obi L. Griffith.
## Download Data
```
# Download the data
wget -nc  http://data.biostarhandbook.com/data/uhr-hbr.tar.gz

# Unpack the data
tar xzvf uhr-hbr.tar.gz
```
## Generate counts.txt
```
make counts
```
## Generate design.csv
```
make design
```

# Continue
## Change to stats Environment
```
conda activate stats
```
## Generate pca and heatmap
```
make qc
```
# Visualization
## PCA

<img width="886" height="267" alt="Screenshot 2025-12-15 at 01 47 23" src="https://github.com/user-attachments/assets/b33da6a2-8ae5-4ba7-a444-c2b09524d950" />

## Heatmap 

<img width="614" height="664" alt="Screenshot 2025-12-15 at 01 47 42" src="https://github.com/user-attachments/assets/e637980c-9b49-43b7-81d8-d081429db79d" />


## Identify a set of differentially expressed genes or transcripts
```
# Run edgeR
Rscript src/r/edger.r -d design.csv -c counts.csv
# Run DESeq2
Rscript src/r/deseq2.r -d design.csv -c counts.csv
# Filter DE genes (FDR < 0.05)
awk -F, 'NR==1 || $NF+0 < 0.05' edger.csv > edger_fdr0.05.csv
```
<img width="1129" height="142" alt="Screenshot 2025-12-15 at 01 31 50" src="https://github.com/user-attachments/assets/39c0a2d5-b570-45c7-8d21-c1d1f4c03723" />
Those genes' differential expressions are less than 0.05 FDR.
## Perform functional enrichment analysis







