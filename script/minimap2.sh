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

SAMPLE=$1

mkdir -p $PWD/output/minimap2/${SAMPLE}

singularity run $PWD/image/minimap2_2.17.sif \
  sh -c "minimap2 -ax map-ont -t 8 -p 0.1 \
    /home/aiokada/resources/database/GRCh38.d1.vd1-minimap2/GRCh38.d1.vd1.mmi \
    $PWD/output/fastq/${SAMPLE}/S.fastq \
  | samtools view -Shb > $PWD/output/minimap2/${SAMPLE}/${SAMPLE}.unsorted"

samtools sort -@ 8 -m 2G $PWD/output/minimap2/${SAMPLE}/${SAMPLE}.unsorted -o $PWD/output/minimap2/${SAMPLE}/${SAMPLE}.aligned.bam
samtools index $PWD/output/minimap2/${SAMPLE}/${SAMPLE}.aligned.bam

rm -rf $PWD/output/minimap2/${SAMPLE}/${SAMPLE}.unsorted
