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

TUMOR_BAM=$1
CONTROL_BAM=$2
TUMOR_DIR=$3
CONTROL_DIR=$4
REFERENCE=$5
CONTROL_PANEL_PREFIX=$6

singularity exec $PWD/image/nanomonsv_v0.5.0.sif \
  nanomonsv get \
    ${TUMOR_DIR} \
    ${TUMOR_BAM} \
    ${REFERENCE} \
    --control_prefix ${CONTROL_DIR} \
    --control_bam ${CONTROL_BAM} \
    --processes 8 \
    --single_bnd \
    --use_racon \
    --control_panel_prefix ${CONTROL_PANEL_PREFIX}
