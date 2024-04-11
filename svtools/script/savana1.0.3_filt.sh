#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=12G

set -eux

TUMOR_VCF=$1
OUTPUT_DIR=$2

mkdir -p ${OUTPUT_DIR}

# somatic filter with controls + convert to nanomonsv format
#singularity exec $PWD/image/ob_utils_0.0.12b.sif \
source ~/venv/ob_utils_devel/bin/activate

# installed ob-utils-0.0.12.4

    ob_utils savana1.0.3_sv \
    --in_savana_tumor_sv ${TUMOR_VCF} \
    --output ${OUTPUT_DIR}/savana_sv.txt \
    --filter_scaffold_option \
    --f_grc --debug

# filtering
singularity exec /home/aiokada/sandbox/benchmark_COLO829/image/simulationsv-set_0.1.0.sif  \
    python3 /home/aiokada/sandbox/benchmark_COLO829/simulation_sv_set/script/rmdup.py \
    ${OUTPUT_DIR}/savana_sv.txt > \
    ${OUTPUT_DIR}/savana_sv.rmdup.txt
