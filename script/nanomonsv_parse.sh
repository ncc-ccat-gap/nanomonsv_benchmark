#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=20G

set -eux

INPUT_BAM=$1
OUTPUT_PREFIX=$2

apptainer exec $PWD/image/nanomonsv_v0.5.0.sif \
  nanomonsv parse \
    ${INPUT_BAM} \
    ${OUTPUT_PREFIX}
