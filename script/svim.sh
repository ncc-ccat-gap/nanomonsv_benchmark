#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=16G

set -eux

INPUT_BAM=$1
OUTPUT_DIR=$2
REFERENCE=$3

IMAGE_DIR=$(dirname $0)/../image

mkdir -p ${OUTPUT_DIR}

apptainer exec ${IMAGE_DIR}/svim_2.0.0.sif \
  svim alignment \
    --skip_genotyping \
    ${OUTPUT_DIR} \
    ${INPUT_BAM} \
    ${REFERENCE}
