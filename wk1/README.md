# Week 1 assignment
## Create a new directory 
```python
mkdir wk1
```
## Add a README.md file to the directory
```python
cd wk1
touch README.md
```
## Version of samtools command in the bioinfo environment
```python
conda activate bioinfo
samtools --version
samtools 1.22.1
Using htslib 1.22.1
Copyright (C) 2025 Genome Research Ltd.
```
## Commands needed to create a nested directory structure.
```python
mkdir -p 2025/fall/week1/data
```
## Commands that create files in different directories
```python
touch 2025/fall/week1/data/sample.txt
touch 2025/fall/week1/notes.txt
```
## Commands to access these files using relative and absolute paths.
### Relative paths
```python
cat 2025/fall/week1/data/sample.txt
cat 2025/fall/week1/notes.txt
```
### Absolute paths
```python
cat /Users/sijia/BMMB852-week1/2025/fall/week1/data/sample.txt
cat /Users/sijia/BMMB852-week1/2025/fall/week1/notes.txt
```
## Upload in Github
```python
git init
git add .
git commit -m "BMMB852 week1 assignment"
git branch -M main
git remote add origin https://github.com/sijyanggg/BMMB852-assigment1.git
git push -u origin main
```
