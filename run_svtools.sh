set -eux

SVTOOL=$1
BAM_TUMOR=$2
BAM_NORMAL=$3
OUTPUT_DIR=$4
REFERENCE=$5

WDIR=${OUTPUT_DIR}/${SVTOOL}

if [ $SVTOOL = "camphor" ]
then

    FASTQ_SECONDARY=${WDIR}/fastq/S.fastq
    OUTPUT_DIR_TUMOR=${WDIR}/tumor
    OUTPUT_DIR_NORMAL=${WDIR}/normal
    OUTPUT_TUMOR=${OUTPUT_DIR_TUMOR}/somatic_SV.vcf

    if [ ! -e ${FASTQ_SECONDARY} ]; then
      qsub -N camphor_bamtofastq $PWD/script/bamtofastq.sh ${BAM_TUMOR} ${WDIR}
    fi

    qsub -N camphor_svcall_tumor $PWD/script/camphor_svcall.sh ${BAM_TUMOR} ${OUTPUT_DIR_TUMOR} ${REFERENCE}
    qsub -N camphor_svcall_normal $PWD/script/camphor_svcall.sh ${BAM_NORMAL} ${OUTPUT_DIR_NORMAL} ${REFERENCE}

    qsub -N ${SVTOOL} -hold_jid camphor_bamtofastq,camphor_svcall_tumor,camphor_svcall_normal $PWD/script/camphor_comparision.sh \
        ${OUTPUT_DIR_TUMOR} ${OUTPUT_DIR_NORMAL} ${BAM_TUMOR} ${BAM_NORMAL} ${FASTQ_SECONDARY} ${OUTPUT_DIR_TUMOR}
    qsub -N ${SVTOOL}_filt -hold_jid ${SVTOOL} $PWD/script/${SVTOOL}_filt.sh ${OUTPUT_TUMOR} ${WDIR}/filt

if [ $SVTOOL = "savana" ]
then
    OUTPUT_DIR_TUMOR=${WDIR}/tumor
    OUTPUT_TUMOR=${OUTPUT_DIR_TUMOR}/$(basename ${OUTPUT_DIR_TUMOR}/*.sv_breakpoints.vcf)

    qsub -N ${SVTOOL} $PWD/script/savana.sh ${BAM_TUMOR} ${BAM_NORMAL} ${OUTPUT_DIR_TUMOR} ${REFERENCE}
    qsub -N ${SVTOOL}_filt -hold_jid ${SVTOOL} $PWD/script/${SVTOOL}_filt.sh ${OUTPUT_TUMOR} ${WDIR}/filt

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

    elif [ $SVTOOL = "SVIM" ]
    then
        OUTPUT_TUMOR=${WDIR}/tumor/variants.vcf
        OUTPUT_NORMAL=${WDIR}/normal/variants.vcf
    else
        echo "Unexpected svtool "${SVTOOL}
        exit 1

    qsub -N ${SVTOOL}_tumor $PWD/script/${SVTOOL}.sh ${BAM_TUMOR} ${OUTPUT_TUMOR} ${REFERENCE}
    qsub -N ${SVTOOL}_normal $PWD/script/${SVTOOL}.sh ${BAM_NORMAL} ${OUTPUT_NORMAL} ${REFERENCE}

fi

qsub -N ${SVTOOL}_filt -hold_jid ${SVTOOL}_tumor,${SVTOOL}_normal $PWD/script/${SVTOOL}_filt.sh ${OUTPUT_TUMOR} ${OUTPUT_NORMAL} ${WDIR}/filt

## benchmark commands

python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.sniffles2_sv.rmdup.txt > ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.txt

python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.txt ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5

head -n 1 ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.pass.txt

python3 benchmark_compare.py ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.sniffles2.benchmark.result.txt ../output/COLO829_T_Nanopore.sniffles2.Arora_2019.txt ../output/COLO829_T_Nanopore.sniffles2.Valle-Inclan_2020.txt
