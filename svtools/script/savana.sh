#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=45G
#$ -l mem_req=45G
#$ -pe def_slot 8

set -eux

TUMOR_BAM=$1
NORMAL_BAM=$2
OUTPUT_DIR=$3
REFERENCE=$4

mkdir -p ${OUTPUT_DIR}

singularity exec $PWD/image/savana_0.2.3.sif \
  savana \
    --tumour ${TUMOR_BAM} \
    --normal ${NORMAL_BAM} \
    --outdir ${OUTPUT_DIR} \
    --ref    ${REFERENCE} \
    --threads 8
