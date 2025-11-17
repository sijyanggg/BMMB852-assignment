# Wk12 Assignment
## Goal
Evaluate alignments across sequencing platforms
## Oncogene in pancreatic cancer: CDKN2A
CDKN2A encodes protein that helps regulate the cell cycle by inhibiting CDK4 or stabilizing p53, both are key in preventing uncontrolled cell division. Loss or malfunction of these regulatory functions can lead to unchecked cell growth and tumor development. Therefore, I choose this to see whether if it is tumor specific related mutation.
## Download BAM files for the same region from 2-3 different platforms (ILLUMINA, ULTIMA, OXFORD_NANOPORE, ELEMENT
### Download reference genome and index.
```
make ref 
```
### Make BAM
```
cat design.csv | \
    parallel --colsep , --header : --eta --lb -j 4 \
        make \
        SEQTECH={Run} \
        align
```

| SRR | Sequencing Technologies | Read depth | Mapping quality | coverage uniformity |
|--------|------|------| ------|------|
| SRR33291168 | ILLUMINA (Illumina NovaSeq X Plus) |
| SRR33291173 | ULTIMA (UG 100) |
| SRR33291172 | OXFORD_NANOPORE |
| SRR30945809 | ELEMENT (Element AVITI) |
