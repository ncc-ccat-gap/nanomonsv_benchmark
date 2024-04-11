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

TUMOR_VCF=$1
OUTPUT_DIR=$2

mkdir -p ${OUTPUT_DIR}

# somatic filter with controls + convert to nanomonsv format
singularity exec $PWD/image/ob_utils_0.0.12b.sif \
    ob_utils camphor_sv \
    --in_camphor_tumor_sv ${TUMOR_VCF} \
    --output ${OUTPUT_DIR}/camphor_sv.txt \
    --filter_scaffold_option \
    --f_grc
    
# filtering
singularity exec $PWD/image/simulationsv-set_0.1.0.sif  \
    python3 $PWD/simulation_sv_set/script/rmdup.py \
    ${OUTPUT_DIR}/camphor_sv.txt > \
    ${OUTPUT_DIR}/camphor_sv.rmdup.txt
