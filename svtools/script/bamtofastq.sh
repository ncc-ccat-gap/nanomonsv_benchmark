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
#$ -l s_vmem=24G

set -eux

INPUT_BAM=$1
OUTPUT_DIR=$2

singularity exec $PWD/image/bwa_alignment_0.2.0.sif \
    bash $PWD/script/shell_bamtofastq.sh ${INPUT_BAM} ${OUTPUT_DIR}

