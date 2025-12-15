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



