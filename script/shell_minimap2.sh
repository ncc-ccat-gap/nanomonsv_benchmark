#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -l d_rt=2880:00:00   # 4 month
#$ -l s_rt=2880:00:00
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=6G
#$ -pe def_slot 8
set -eux -o pipefail

INPUT_FASTQ=$1
OUTPUT_BAM=$2
REFERENCE=$3

mkdir -p $(dirname ${OUTPUT_BAM})

minimap2 -ax map-ont -t 8 -p 0.1 \
  ${REFERENCE} ${INPUT_FASTQ} | samtools view -Shb > ${OUTPUT_BAM}.unsorted

samtools sort -@ 8 -m 2G ${OUTPUT_BAM}.unsorted -o ${OUTPUT_BAM}
samtools index ${OUTPUT_BAM}

rm -rf ${OUTPUT_BAM}.unsorted
