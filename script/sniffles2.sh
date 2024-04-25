#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=4G
#$ -pe def_slot 8

set -eux

INPUT_BAM=$1
OUTPUT_VCF=$2

IMAGE_DIR=$(dirname $0)/../image

apptainer exec ${IMAGE_DIR}/sniffles2_2.0.7.sif \
  sniffles \
    -i ${INPUT_BAM} \
    -v ${OUTPUT_VCF} \
    --minsupport 1 --threads 8 --non-germline
