# Week5 Assignment
## Scientific Publication from last week
Genomic surveillance elucidates Ebola virus origin and transmission during the 2014 outbreak

BioProject: PRJNA257197

SRR: SRR1972976	
## Create a bash shell script with the code from last week.
```
# set trace
set -xeuo pipefail

ACC="${1:-GCF_000848505.1}"   # Reference genome accession
OUTDIR="${2:-week5_${ACC}}"   # Output folder
SRR="${3:-SRR1972976}"        # SRR number
PRJN="${4:-PRJNA257197}"      # BioProject number

# -------------No Change Below This Line-------------------

# Change environment 
micromamba activate bioinfo

# Prepare workspace
mkdir -p "${OUTDIR}"
cd "${OUTDIR}"

# Download genome data
datasets download genome accession "${ACC}" --include genome,gff3,gtf
unzip -n ncbi_dataset.zip
cd "ncbi_dataset/data/${ACC}"
ls -l

# Locate FASTA and GFF files robustly
shopt -s nullglob
FASTA_FILES=( *.fna *.fa *.fasta )
GFF_FILES=( genomic.gff *.gff *.gff3 )

if [ ${#FASTA_FILES[@]} -eq 0 ]; then
  echo "No FASTA (*.fna/*.fa/*.fasta) found for ${ACC}" >&2
  exit 1
fi
if [ ${#GFF_FILES[@]} -eq 0 ]; then
  echo "No GFF (genomic.gff/*.gff/*.gff3) found for ${ACC}" >&2
  exit 1
fi

FASTA="${FASTA_FILES[0]}"
GFF="${GFF_FILES[0]}"

echo "Using FASTA: ${FASTA}"
echo "Using GFF:    ${GFF}"

# Genome Size
seqkit stats "${FASTA}" > ../../seqkit_stats.${ACC}.txt

# Number of freatures of each type in GFF file
grep -v "^#" "${GFF}" | cut -f3 | sort | uniq -c | sort -n > ../../feature_counts.${ACC}.txt

# The longest gene and its name and function
awk '$3=="gene"{print $5-$4+1, $0}' "${GFF}" | sort -k1,1nr | head -1 > ../../longest_gene.${ACC}.txt

# Other gene names
awk '$3=="gene"{print $9}' "${GFF}" > ../../gene_attributes.${ACC}.txt
```
## Add commands to download at least one sequencing dataset using the SRR number(s) and download only a subset of the data that would provide approximately 10x genome coverage.
### Estimated the amount of data needed for 10x coverage
C = L / G

Coverage is 10X. G is genome length (sun length is 18,959. Therefore target length is about 1,896 bp. So I choose 
```
# Obtain run metadata based on SRR number
cd ../../..

if command -v bio >/dev/null 2>&1; then
  mkdir -p metadata
  echo "Obtaining metadata for SRR: ${SRR}"
  bio search "${SRR}" > "metadata/${SRR}.metadata.txt" || true
else
  echo "[info] 'bio' CLI not found; skipping metadata search."
fi

# Download subset of data with 10x genome coverage
if command -v fastq-dump >/dev/null 2>&1; then
  mkdir -p reads
  echo "Downloading subset of 2000 reads for SRR: ${SRR}"
  fastq-dump -X 2000 -F --outdir reads --split-files "${SRR}"
else
  echo "[warn] 'fastq-dump' not found; skipping subset read download."
fi
```
## Quality assessment:
### Basic statistics on the downloaded reads
```
shopt -s nullglob
for fq in reads/*.fastq; do gzip -f "$fq"; done
shopt -u nullglob

if command -v seqkit >/dev/null 2>&1; then
  if ls reads/*.fastq.gz >/dev/null 2>&1; then
    seqkit stats reads/*.fastq.gz > read_stats.${SRR}.txt
  elif ls reads/*.fq.gz >/dev/null 2>&1; then
    seqkit stats reads/*.fq.gz > read_stats.${SRR}.txt
  fi
else
  echo "[warn] 'seqkit' not found; skipping read stats."
fi
```
### Run FASTQC on the downloaded data to generate a quality report.
```
if command -v fastqc >/dev/null 2>&1; then
  mkdir -p qc
  READ_FILES=( reads/*.fastq.gz reads/*.fq.gz )
  if [ ${#READ_FILES[@]} -gt 0 ]; then
    fastqc "${READ_FILES[@]}"
  fi
else
  echo "[warn] 'fastqc' not found; skipping FASTQC."
fi
```
### Evaluate the FASTQC report and summarize findings.
The read 1 is high quality at the start but is noisy at end and shoud be trimmed. The read 2 is overall worse than read 1 with significant 3'-end quality drop. Both reads fail the FASTQC "Per base sequence quality" because of low Q-scores toward the end. Read 1 is better but both need trimming. This wull hurt mapping or assembly and increase error rate.
<img width="1005" height="648" alt="Screenshot 2025-09-29 at 02 52 01" src="https://github.com/user-attachments/assets/2d5b714e-acfc-40d5-99a7-5175c55b8675" />
<img width="1017" height="665" alt="Screenshot 2025-09-29 at 02 51 46" src="https://github.com/user-attachments/assets/65ae0bbd-f7af-4b5e-ab24-5f712510e17b" />

## Compare sequencing platforms
### Search the SRA for another dataset for the same genome, but generated using a different sequencing platform
### Briefly compare the quality or characteristics of the datasets from the two platforms.


