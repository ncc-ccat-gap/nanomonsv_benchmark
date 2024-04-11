#!/bin/bash
set -eux

TUMOR_DIR=$1
CONTROL_DIR=$2
TUMOR_BAM=$3
CONTROL_BAM=$4
TUMOR_FASTQ=$5
OUTPUT_DIR=$6

cd /tools/CAMPHORsomatic
sh ./CAMPHOR_comparison.sh \
    ${TUMOR_DIR} \
    ${CONTROL_DIR} \
    ${TUMOR_BAM} \
    ${CONTROL_BAM} \
    ${TUMOR_FASTQ} \
    ${OUTPUT_DIR}
