#!/bin/bash
#
# Set SGE
#
#$ -S /bin/bash         # set shell in UGE
#$ -cwd                 # execute at the submitted dir
#$ -e ./log/
#$ -o ./log/
#$ -j y
#$ -l s_vmem=2G

set -eux

SVTOOL=$1
BAM_TUMOR=$2
BAM_NORMAL=$3
OUTPUT_DIR=$4
REFERENCE=$5

SCRIPT_DIR=$PWD/script

if [ $SVTOOL = "nanomonsv" ]
then
    OUTPUT_PREFIX_TUMOR=${OUTPUT_DIR}/tumor/tumor
    OUTPUT_PREFIX_NORMAL=${OUTPUT_DIR}/normal/normal
    OUTPUT_TUMOR_TXT=${OUTPUT_PREFIX_TUMOR}.nanomonsv.result.txt
    OUTPUT_TUMOR_VCF=${OUTPUT_PREFIX_TUMOR}.nanomonsv.result.vcf
    CONTROL_PANEL_PREFIX=$PWD/control_panel/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control

    qsub -N nanomonsv_parse ${SCRIPT_DIR}/nanomonsv_parse.sh ${BAM_TUMOR} ${OUTPUT_PREFIX_TUMOR}
    qsub -N nanomonsv_parse ${SCRIPT_DIR}/nanomonsv_parse.sh ${BAM_NORMAL} ${OUTPUT_PREFIX_NORMAL}
    
    qsub -N ${SVTOOL} -hold_jid nanomonsv_parse ${SCRIPT_DIR}/nanomonsv_get.sh \
        ${BAM_TUMOR} ${BAM_NORMAL} ${OUTPUT_PREFIX_TUMOR} ${OUTPUT_PREFIX_NORMAL} \
        ${REFERENCE} ${CONTROL_PANEL_PREFIX}

    qsub -N ${SVTOOL}_filt -hold_jid ${SVTOOL} ${SCRIPT_DIR}/filt_nanomonsv.sh ${OUTPUT_TUMOR_TXT} ${OUTPUT_TUMOR_VCF} ${OUTPUT_DIR} ${REFERENCE}

else
    if [ $SVTOOL = "camphor" ]
    then
        FASTQ_TUMOR=$6
        OUTPUT_DIR_TUMOR=${OUTPUT_DIR}/tumor
        OUTPUT_DIR_NORMAL=${OUTPUT_DIR}/normal
        OUTPUT_TUMOR=${OUTPUT_DIR_TUMOR}/somatic_SV.vcf
        OUTPUT_NORMAL=None

        qsub -N camphor_svcall ${SCRIPT_DIR}/camphor_svcall.sh ${BAM_TUMOR} ${OUTPUT_DIR_TUMOR} ${REFERENCE}
        qsub -N camphor_svcall ${SCRIPT_DIR}/camphor_svcall.sh ${BAM_NORMAL} ${OUTPUT_DIR_NORMAL} ${REFERENCE}
        
        qsub -N ${SVTOOL} -hold_jid camphor_bamtofastq,camphor_svcall ${SCRIPT_DIR}/camphor_comparision.sh \
            ${OUTPUT_DIR_TUMOR} ${OUTPUT_DIR_NORMAL} ${BAM_TUMOR} ${BAM_NORMAL} ${FASTQ_TUMOR} ${OUTPUT_DIR_TUMOR}

    elif [ $SVTOOL = "savana" ]
    then
        OUTPUT_DIR_TUMOR=${OUTPUT_DIR}/tumor
        OUTPUT_TUMOR=${OUTPUT_DIR_TUMOR}/$(basename ${OUTPUT_DIR_TUMOR}/*.sv_breakpoints.vcf)
        OUTPUT_NORMAL=None

        qsub -N ${SVTOOL} ${SCRIPT_DIR}/savana.sh ${BAM_TUMOR} ${BAM_NORMAL} ${OUTPUT_DIR_TUMOR} ${REFERENCE}

    else

        if [ $SVTOOL = "delly" ]
        then
            OUTPUT_TUMOR=${OUTPUT_DIR}/tumor/delly.bcf
            OUTPUT_NORMAL=${OUTPUT_DIR}/normal/delly.bcf

        elif [ $SVTOOL = "sniffles2" ]
        then
            OUTPUT_TUMOR=${OUTPUT_DIR}/tumor/sniffles2.vcf
            OUTPUT_NORMAL=${OUTPUT_DIR}/normal/sniffles2.vcf

        elif [ $SVTOOL = "cutesv" ]
        then
            OUTPUT_TUMOR=${OUTPUT_DIR}/tumor/cutesv.vcf
            OUTPUT_NORMAL=${OUTPUT_DIR}/normal/cutesv.vcf

        elif [ $SVTOOL = "svim" ]
        then
            OUTPUT_TUMOR=${OUTPUT_DIR}/tumor/variants.vcf
            OUTPUT_NORMAL=${OUTPUT_DIR}/normal/variants.vcf
        else
            echo "Unexpected svtool "${SVTOOL}
            exit 1
        fi
        qsub -N ${SVTOOL} ${SCRIPT_DIR}/${SVTOOL}.sh ${BAM_TUMOR} ${OUTPUT_TUMOR} ${REFERENCE}
        qsub -N ${SVTOOL} ${SCRIPT_DIR}/${SVTOOL}.sh ${BAM_NORMAL} ${OUTPUT_NORMAL} ${REFERENCE}

    fi

    qsub -N ${SVTOOL}_filt -hold_jid ${SVTOOL} ${SCRIPT_DIR}/filt_svtools.sh ${SVTOOL} ${OUTPUT_TUMOR} ${OUTPUT_NORMAL} ${OUTPUT_DIR}
fi
