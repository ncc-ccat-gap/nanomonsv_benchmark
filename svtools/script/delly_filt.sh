#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=8G

set -eux

TUMOR_BCF=$1
CONTROL_BCF=$2
OUTPUT_DIR=$3

mkdir -p ${OUTPUT_DIR}

# somatic filter with controls + convert to nanomonsv format
singularity exec $PWD/image/ob_utils_0.0.12b.sif \
    ob_utils delly_sv \
    --in_delly_tumor_sv ${TUMOR_BCF} \
    --in_delly_control_sv ${CONTROL_BCF} \
    --output ${OUTPUT_DIR}/delly_sv.txt \
    --filter_scaffold_option \
    --f_grc --margin 200 --max_control_support_read 0
    
# filtering
singularity exec $PWD/image/simulationsv-set_0.1.0.sif  \
    python3 $PWD/simulation_sv_set/script/rmdup.py \
    ${OUTPUT_DIR}/delly_sv.txt > \
    ${OUTPUT_DIR}/delly_sv.rmdup.txt
