#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=256G
#$ -pe def_slot 2
#$ -l d_rt=2880:00:00   # 4 month
#$ -l s_rt=2880:00:00

set -eux

TUMOR_BAM=$1
NORMAL_BAM=$2
OUTPUT_DIR=$3
REFERENCE=$4

mkdir -p ${OUTPUT_DIR}

singularity exec $PWD/image/savana_1.0.3.sif \
  savana run \
    --tumour ${TUMOR_BAM} \
    --normal ${NORMAL_BAM} \
    --outdir ${OUTPUT_DIR} \
    --ref    ${REFERENCE} \
    --threads 2
