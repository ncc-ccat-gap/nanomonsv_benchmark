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
CONTROL_VCF=$2
OUTPUT_DIR=$3

mkdir -p ${OUTPUT_DIR}

# somatic filter with controls + convert to nanomonsv format

if [ CONTROL_VCF != "None" ]
then
  singularity exec ${IMAGE_OBUTIL} \
    python3 simulation_sv_set/ob_utils/${SVTOOL}_util.py \
      --in_tumor_sv ${TUMOR_VCF} \
      --output ${OUTPUT_DIR}/${SVTOOL}_sv.txt \
      --filter_scaffold_option --f_grc
else
  singularity exec ${IMAGE_OBUTIL} \
    python3 simulation_sv_set/ob_utils/${SVTOOL}_util.py \
      --in_tumor_sv ${TUMOR_VCF} \
      --in_control_sv ${CONTROL_VCF} \
      --output ${OUTPUT_DIR}/${SVTOOL}_sv.txt \
      --filter_scaffold_option --f_grc \
      --margin 200 --max_control_support_read 0
fi

# filtering
singularity exec ${IMAGE_SIMULATIONSVSET}  \
    python3 simulation_sv_set/script/rmdup.py \
    ${OUTPUT_DIR}/${SVTOOL}_sv.txt > \
    ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.txt
