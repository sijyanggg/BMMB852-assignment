# Week 1 assignment
## Create a new directory 
```
mkdir wk1
```
## Add a README.md file to the directory
```
cd wk1
touch README.md
```
## Commands for version of samtools in the bioinfo environment
```
conda activate bioinfo
samtools --version
```
## Version of samtools in the bioinfo environment
```
samtools 1.22.1
Using htslib 1.22.1
Copyright (C) 2025 Genome Research Ltd.
```
## Commands needed to create a nested directory structure.
```
mkdir -p 2025/fall/week1/data
```
## Commands that create files in different directories
```
touch 2025/fall/week1/data/sample.txt
touch 2025/fall/week1/notes.txt
```
## Commands to access these files using relative and absolute paths.
### Relative paths
```
cat 2025/fall/week1/data/sample.txt
cat 2025/fall/week1/notes.txt
```
### Absolute paths
```
cat /Users/sijia/BMMB852-week1/2025/fall/week1/data/sample.txt
cat /Users/sijia/BMMB852-week1/2025/fall/week1/notes.txt
```
## Upload in Github
```
git init
git add .
git commit -m "BMMB852 week1 assignment"
git branch -M main
git remote add origin https://github.com/sijyanggg/BMMB852-assigment1.git
git push -u origin main
```
