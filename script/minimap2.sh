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

apptainer run $PWD/image/minimap2_2.17.sif \
  bash $PWD/script/shell_minimap2.sh ${INPUT_FASTQ} ${OUTPUT_BAM} ${REFERENCE}
