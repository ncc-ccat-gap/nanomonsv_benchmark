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

TUMOR_TXT=$1
TUMOR_VCF=$2
OUTPUT_DIR=$3

mkdir -p ${OUTPUT_DIR}

# filtering
#singularity exec $PWD/image/ob_utils_0.0.12.sif  \
singularity exec $PWD/image/ob_utils_0.0.12b.sif  \
    python3 $PWD/simulation_sv_set/script/nanomonsv_filter.py \
    ${TUMOR_TXT} \
    ${TUMOR_VCF} > \
    ${OUTPUT_DIR}/nanomonsv_sv.filt.txt

singularity exec $PWD/image/simulationsv-set_0.1.0.sif  \
    python3 $PWD/simulation_sv_set/script/rmdup.py \
    ${OUTPUT_DIR}/nanomonsv_sv.filt.txt > \
    ${OUTPUT_DIR}/nanomonsv_sv.filt2.txt

# sort by chromosome + filtering scaffold
singularity exec $PWD/image/simulationsv-set_0.1.0.sif  \
    python3 $PWD/simulation_sv_set/script/sort_bedpe.py \
    ${OUTPUT_DIR}/nanomonsv_sv.filt2.txt > \
    ${OUTPUT_DIR}/nanomonsv_sv.rmdup.txt
