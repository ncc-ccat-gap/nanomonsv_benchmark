#!/bin/bash
set -eux

RUNID=$1
SAMPLE=$2

export LD_LIBRARY_PATH=/usr/local/lib

mkdir -p $PWD/output/fastq/${SAMPLE}

/usr/local/bin/bamtofastq collate=1 exclude=QCFAIL,SECONDARY,SUPPLEMENTARY tryoq=0 \
    filename=$PWD/bam/${RUNID}.bam \
    F=$PWD/output/fastq/${SAMPLE}/R1.fastq \
    F2=$PWD/output/fastq/${SAMPLE}/R2.fastq \
    T=$PWD/output/fastq/${SAMPLE}/temp.txt \
    S=$PWD/output/fastq/${SAMPLE}/S.fastq \
    O=$PWD/output/fastq/${SAMPLE}/unmatched_first_output.txt \
    O2=$PWD/output/fastq/${SAMPLE}/unmatched_second_output.txt

gzip $PWD/output/fastq/${SAMPLE}/S.fastq
