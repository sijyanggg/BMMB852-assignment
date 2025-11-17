# Wk12 Assignment
## Goal
Evaluate alignments across sequencing platforms
## Oncogene in pancreatic cancer: CDKN2A
CDKN2A encodes protein that helps regulate the cell cycle by inhibiting CDK4 or stabilizing p53, both are key in preventing uncontrolled cell division. Loss or malfunction of these regulatory functions can lead to unchecked cell growth and tumor development. Therefore, I choose this to see whether if it is tumor specific related mutation.
## Download BAM files for the same region from 2-3 different platforms 
### Download reference genome and index.
```
make ref 
```
### Make BAM
```
cat design.csv | \
    parallel --colsep , --header : --eta --lb -j 4 \
        make \
        SEQTECH={Tech} \
        BAM_URL={URL} \
        align
```
## Alignment statistics
| Sequencing Technologies | Total reads | Mapped reads | percentage mapped reads | percentage properly paired | Singletons |
|------|------| ------|------|------|------|
| Element_AVIT | 15571 | 15500 | 99.54% | 98.33% | 0.46% |
| Illumina | 28257 | 28159 | 99.65% | 98.12% | 0.35% |
| PacBio_Revio | 153 | 153 | 100% | N/A | N/A |

## Visualize alignments in IGV

<img width="1295" height="387" alt="Screenshot 2025-11-17 at 01 25 47" src="https://github.com/user-attachments/assets/af51dd10-19aa-4288-a63b-b76fa5603660" />
In the CDKN2A locus on chr9, different sequencing technologies exhibit distinct coverage characteristics when visualized in IGV. Illumina short-read sequencing provides high-depth and highly uniform coverage across the gene, serving as a canonical benchmark. Element AVITI, which also generates short reads but with different chemistry, produces a broadly similar profile but with slightly reduced depth and more local variability. In contrast, PacBio Revio HiFi long-read sequencing shows lower overall coverage but a remarkably flat and uniform signal, reflecting its high-accuracy long reads and reduced GC-related bias. These differences illustrate how sequencing platform, read length, and underlying chemistry can influence depth, noise, and uniformity at the CDKN2A locus, which is biologically relevant because this tumor suppressor gene resides in a complex, highly studied region frequently altered in cancer.
