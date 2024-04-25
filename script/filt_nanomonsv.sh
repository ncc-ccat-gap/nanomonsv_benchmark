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

SVTOOL=$1
TUMOR_TXT=$1
TUMOR_VCF=$2
OUTPUT_DIR=$3

DB_DIR=$PWD/db
IMAGE_SIMULATIONSVSET=$PWD/image/simulationsv-set_0.1.0.sif

mkdir -p ${OUTPUT_DIR}/filt
mkdir -p ${OUTPUT_DIR}/benchmark

# filtering
apptainer exec ${IMAGE_SIMULATIONSVSET}  \
  python3 $PWD/simulation_sv_set/script/nanomonsv_filter.py \
    ${TUMOR_TXT} \
    ${TUMOR_VCF} > \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.filt.txt

apptainer exec ${IMAGE_SIMULATIONSVSET}  \
  python3 $PWD/simulation_sv_set/script/rmdup.py \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.filt.txt > \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.filt2.txt

# sort by chromosome + filtering scaffold
apptainer exec ${IMAGE_SIMULATIONSVSET}  \
  python3 $PWD/simulation_sv_set/script/sort_bedpe.py \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.filt2.txt > \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.txt

## benchmark commands
apptainer exec ${IMAGE_SIMULATIONSVSET}  \
  python3 add_simple_repeat.py \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.txt ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.txt ${DB_DIR}/simpleRepeat.bed.gz --min_tumor_support_read 5

head -n 1 ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.txt \
  > ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.txt
tail -n +2 ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.txt | grep PASS \
  >> ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.txt

apptainer exec ${IMAGE_SIMULATIONSVSET}  \
python3 add_repeat.py ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.txt \
  ${DB_DIR}/gene.bed.gz ${DB_DIR}/simpleRepeat.bed.gz > ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.add_repeat.txt

apptainer exec ${IMAGE_SIMULATIONSVSET}  \
  nanomonsv insert_classify \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.add_repeat.txt \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.add_repeat.classify.txt \
    ${reference} --genome_id hg38

apptainer exec ${IMAGE_SIMULATIONSVSET}  \
  python3 final_filter2.py \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.add_repeat.classify.txt \
    ${DB_DIR}/COLO829.nanomonsv.review_YS.txt ${DB_DIR}/cancer_gene_census_20200505.csv \
    > ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.add_repeat.classify.filter2.txt

## benchmark compare
apptainer exec ${IMAGE_SIMULATIONSVSET}  \
  python3 benchmark_compare.py \
    ${OUTPUT_DIR}/filt/${SVTOOL}_sv.rmdup.filt.pass.add_repeat.classify.filter2.txt \
    ${DB_DIR}/Arora_2019.txt \
    ${DB_DIR}/Valle-Inclan_2020.txt \
    ${OUTPUT_DIR}/benchmark/${SVTOOL}_sv.benchmark.result.txt \
    ${OUTPUT_DIR}/benchmark/${SVTOOL}_sv.Arora_2019.txt \
    ${OUTPUT_DIR}/benchmark/${SVTOOL}_sv.Valle-Inclan_2020.txt

