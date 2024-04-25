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
OUTPUT_VCF=$2
REFERENCE=$3

OUTPUT_DIR=$(dirname ${OUTPUT_VCF})
mkdir -p ${OUTPUT_DIR}

apptainer exec $PWD/image/svim_2.0.0.sif \
  svim alignment \
    --skip_genotyping \
    ${OUTPUT_DIR} \
    ${INPUT_BAM} \
    ${REFERENCE}
