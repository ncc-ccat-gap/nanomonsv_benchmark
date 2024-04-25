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

SVTOOL=$1
TUMOR_VCF=$2
CONTROL_VCF=$3
OUTPUT_DIR=$4

SCRIPT_DIR=$(dirname $0)
DB_DIR=${SCRIPT_DIR}/${DB_DIR}
IMAGE_OBUTIL=${SCRIPT_DIR}/../image/obutils.sif
IMAGE_SIMULATIONSVSET=${SCRIPT_DIR}/../image/simulationsv-set_0.1.0.sif

mkdir -p ${OUTPUT_DIR}

# somatic filter with controls + convert to nanomonsv format
if [ CONTROL_VCF != "None" ]
then
  singularity exec ${IMAGE_OBUTIL} \
    python3 ${SCRIPT_DIR}/../simulation_sv_set/ob_utils/${SVTOOL}_util.py \
      --in_tumor_sv ${TUMOR_VCF} \
      --output ${OUTPUT_DIR}/${SVTOOL}_sv.txt \
      --filter_scaffold_option --f_grc
else
  singularity exec ${IMAGE_OBUTIL} \
    python3 ${SCRIPT_DIR}/../simulation_sv_set/ob_utils/${SVTOOL}_util.py \
      --in_tumor_sv ${TUMOR_VCF} \
      --in_control_sv ${CONTROL_VCF} \
      --output ${OUTPUT_DIR}/${SVTOOL}_sv.txt \
      --filter_scaffold_option --f_grc \
      --margin 200 --max_control_support_read 0
fi

# filtering
singularity exec ${IMAGE_SIMULATIONSVSET}  \
  python3 ${SCRIPT_DIR}/../simulation_sv_set/script/rmdup.py \
    ${OUTPUT_DIR}/${SVTOOL}_sv.txt > \
    ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.txt

## benchmark commands
singularity exec ${IMAGE_SIMULATIONSVSET}  \
  python3 ${SCRIPT_DIR}/filt/filt_sniffles_svim.py ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.txt > ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.txt

singularity exec ${IMAGE_SIMULATIONSVSET}  \
  python3 ${SCRIPT_DIR}/filt/add_simple_repeat.py \
    ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.txt \
    ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.filt.txt \
    ${DB_DIR}/simpleRepeat.bed.gz --min_tumor_support_read 5

head -n 1 ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.filt.txt \
  > ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.filt.pass.txt
tail -n +2 ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.txt | grep PASS \
  >> ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.pass.txt

singularity exec ${IMAGE_SIMULATIONSVSET}  \
  python3 ${SCRIPT_DIR}/filt/benchmark_compare.py \
    ${OUTPUT_DIR}/${SVTOOL}_sv.rmdup.sniffles2_filtered.proc.filt.pass.txt \
    ${DB_DIR}/Arora_2019.txt \
    ${DB_DIR}/Valle-Inclan_2020.txt \
    ${OUTPUT_DIR}/${SVTOOL}_sv.benchmark.result.txt \
    ${OUTPUT_DIR}/${SVTOOL}_sv.Arora_2019.txt \
    ${OUTPUT_DIR}/${SVTOOL}_sv.Valle-Inclan_2020.txt
