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
#$ -l s_vmem=30G
#$ -l mem_req=30G
#$ -pe def_slot 8

set -eux

TUMOR_DIR=$1
CONTROL_DIR=$2
TUMOR_BAM=$3
CONTROL_BAM=$4
TUMOR_FASTQ=$5
OUTPUT_DIR=$6

mkdir -p ${OUTPUT_DIR}

apptainer exec $PWD/image/camphor_somatic_20221005.sif \
    bash $PWD/script/shell_camphor_comparision.sh ${TUMOR_DIR} ${CONTROL_DIR} ${TUMOR_BAM} ${CONTROL_BAM} ${TUMOR_FASTQ} ${OUTPUT_DIR}
