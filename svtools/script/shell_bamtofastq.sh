#!/bin/bash
set -eux

INPUT_BAM=$1
OUTPUT_DIR=$2

export LD_LIBRARY_PATH=/usr/local/lib

mkdir -p ${OUTPUT_DIR}

/usr/local/bin/bamtofastq collate=1 exclude=QCFAIL,SECONDARY,SUPPLEMENTARY tryoq=0 \
    filename=${INPUT_BAM}.bam \
    F=${OUTPUT_DIR}/R1.fastq \
    F2=${OUTPUT_DIR}/R2.fastq \
    T=${OUTPUT_DIR}/temp.txt \
    S=${OUTPUT_DIR}/S.fastq \
    O=${OUTPUT_DIR}/unmatched_first_output.txt \
    O2=${OUTPUT_DIR}/unmatched_second_output.txt

#gzip $PWD/output/fastq/${SAMPLE}/S.fastq
