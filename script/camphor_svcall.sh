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
OUTPUT_DIR=$2
REFERENCE=$3

SCRIPT_DIR=$(dirname $0)/script
IMAGE_DIR=$(dirname $0)/../image

mkdir -p ${OUTPUT_DIR}

apptainer exec ${IMAGE_DIR}/camphor_somatic_20221005.sif \
    samtools sort -n -@ 8 \
    ${INPUT_BAM} \
    -O bam -o ${OUTPUT_DIR}/sort_by_name.bam

apptainer exec ${IMAGE_DIR}/camphor_somatic_20221005.sif \
    bash ${SCRIPT_DIR}/shell_camphor_svcall.sh \
    ${OUTPUT_DIR}/sort_by_name.bam \
    ${INPUT_BAM} \
    ${OUTPUT_DIR}

rm ${OUTPUT_DIR}/sort_by_name.bam
