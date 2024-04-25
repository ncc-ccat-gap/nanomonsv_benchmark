set -eux

SVTOOL=$1
BAM_TUMOR=$2
BAM_NORMAL=$3
OUTPUT_DIR=$4
REFERENCE=$5

WDIR=${OUTPUT_DIR}/${SVTOOL}
SCRIPT_DIR=$(dirname $0)/script

if [ $SVTOOL = "nanomonsv" ]
then
    OUTPUT_PREFIX_TUMOR=${WDIR}/tumor/tumor
    OUTPUT_PREFIX_NORMAL=${WDIR}/normal/normal
    OUTPUT_TUMOR_TXT=${OUTPUT_PREFIX_TUMOR}.nanomonsv.result.txt
    OUTPUT_TUMOR_VCF=${OUTPUT_PREFIX_NORMAL}.nanomonsv.result.vcf
    CONTROL_PANEL_PREFIX=${SCRIPT_DIR}/control_panel/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control

    qsub -N nanomonsv_parse ${SCRIPT_DIR}/nanomonsv_parse.sh ${BAM_TUMOR} ${OUTPUT_PREFIX_TUMOR}
    qsub -N nanomonsv_parse ${SCRIPT_DIR}/nanomonsv_parse.sh ${NORMAL_BAM} ${OUTPUT_PREFIX_NORMAL}

    qsub -N ${SVTOOL} -hold_jid nanomonsv_parse ${SCRIPT_DIR}/nanomonsv_get.sh \
        ${TUMOR_BAM} ${NORMAL_BAM} ${OUTPUT_PREFIX_TUMOR} ${OUTPUT_PREFIX_NORMAL} \
        ${REFERENCE} ${CONTROL_PANEL_PREFIX}

    qsub -N ${SVTOOL}_filt -hold_jid ${SVTOOL} ${SCRIPT_DIR}/filt_svtools.sh ${SVTOOL} ${OUTPUT_TUMOR_TXT} ${OUTPUT_TUMOR_TXT} ${WDIR}/filt

else
    if [ $SVTOOL = "camphor" ]
    then

        FASTQ_SECONDARY=${WDIR}/fastq/S.fastq
        OUTPUT_DIR_TUMOR=${WDIR}/tumor
        OUTPUT_DIR_NORMAL=${WDIR}/normal
        OUTPUT_TUMOR=${OUTPUT_DIR_TUMOR}/somatic_SV.vcf
        OUTPUT_NORMAL=None

        if [ ! -e ${FASTQ_SECONDARY} ]; then
            qsub -N camphor_bamtofastq ${SCRIPT_DIR}/bamtofastq.sh ${BAM_TUMOR} ${WDIR}
        fi

        qsub -N camphor_svcall ${SCRIPT_DIR}/camphor_svcall.sh ${BAM_TUMOR} ${OUTPUT_DIR_TUMOR} ${REFERENCE}
        qsub -N camphor_svcall ${SCRIPT_DIR}/camphor_svcall.sh ${BAM_NORMAL} ${OUTPUT_DIR_NORMAL} ${REFERENCE}

        qsub -N ${SVTOOL} -hold_jid camphor_bamtofastq,camphor_svcall ${SCRIPT_DIR}/camphor_comparision.sh \
            ${OUTPUT_DIR_TUMOR} ${OUTPUT_DIR_NORMAL} ${BAM_TUMOR} ${BAM_NORMAL} ${FASTQ_SECONDARY} ${OUTPUT_DIR_TUMOR}

    if [ $SVTOOL = "savana" ]
    then
        OUTPUT_DIR_TUMOR=${WDIR}/tumor
        OUTPUT_TUMOR=${OUTPUT_DIR_TUMOR}/$(basename ${OUTPUT_DIR_TUMOR}/*.sv_breakpoints.vcf)
        OUTPUT_NORMAL=None

        qsub -N ${SVTOOL} ${SCRIPT_DIR}/savana.sh ${BAM_TUMOR} ${BAM_NORMAL} ${OUTPUT_DIR_TUMOR} ${REFERENCE}

    else

        if [ $SVTOOL = "delly" ]
        then
            OUTPUT_TUMOR=${WDIR}/tumor/delly.bcf
            OUTPUT_NORMAL=${WDIR}/normal/delly.bcf

        elif [ $SVTOOL = "sniffles2" ]
        then
            OUTPUT_TUMOR=${WDIR}/tumor/sniffles2.vcf
            OUTPUT_NORMAL=${WDIR}/normal/sniffles2.vcf

        elif [ $SVTOOL = "cutesv" ]
        then
            OUTPUT_TUMOR=${WDIR}/tumor/cutesv.vcf
            OUTPUT_NORMAL=${WDIR}/normal/cutesv.vcf

        elif [ $SVTOOL = "svim" ]
        then
            OUTPUT_TUMOR=${WDIR}/tumor/variants.vcf
            OUTPUT_NORMAL=${WDIR}/normal/variants.vcf
        else
            echo "Unexpected svtool "${SVTOOL}
            exit 1

        qsub -N ${SVTOOL} ${SCRIPT_DIR}/${SVTOOL}.sh ${BAM_TUMOR} ${OUTPUT_TUMOR} ${REFERENCE}
        qsub -N ${SVTOOL} ${SCRIPT_DIR}/${SVTOOL}.sh ${BAM_NORMAL} ${OUTPUT_NORMAL} ${REFERENCE}

    fi

    qsub -N ${SVTOOL}_filt -hold_jid ${SVTOOL} ${SCRIPT_DIR}/filt_svtools.sh ${SVTOOL} ${OUTPUT_TUMOR} ${OUTPUT_NORMAL} ${WDIR}/filt
fi
