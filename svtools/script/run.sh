REFERENCE=/home/aiokada/resources/database/GRCh38.d1.vd1/GRCh38.d1.vd1.fa
CONTROL_PANEL_PREFIX=/home/aiokada/resources/control_panel/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control

# nanomonsv-parse
qsub -N nanomonsv_parse_Nanopore $PWD/script/nanomonsv_parse.sh $PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam $PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore
qsub -N nanomonsv_parse_Nanopore $PWD/script/nanomonsv_parse.sh $PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam $PWD/output/nanomonsv/COLO829_R_Nanopore/COLO829_R_Nanopore

qsub -N nanomonsv_parse_PacBio $PWD/script/nanomonsv_parse.sh $PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam $PWD/output/nanomonsv/COLO829_T_PacBio/COLO829_T_PacBio
qsub -N nanomonsv_parse_PacBio $PWD/script/nanomonsv_parse.sh $PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam $PWD/output/nanomonsv/COLO829_R_PacBio/COLO829_R_PacBio

qsub -N nanomonsv_parse_kataoka $PWD/script/nanomonsv_parse.sh $PWD/output/minimap2/COLO829/COLO829.aligned.bam $PWD/output/nanomonsv/COLO829/COLO829
qsub -N nanomonsv_parse_kataoka $PWD/script/nanomonsv_parse.sh $PWD/output/minimap2/COLO829BL/COLO829BL.aligned.bam $PWD/output/nanomonsv/COLO829BL/COLO829BL

# nanomonsv-get
qsub -N nanomonsv_get_Nanopore -hold_jid nanomonsv_parse_Nanopore $PWD/script/nanomonsv_get.sh \
$PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam \
$PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam \
$PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore \
$PWD/output/nanomonsv/COLO829_R_Nanopore/COLO829_R_Nanopore \
${REFERENCE} ${CONTROL_PANEL_PREFIX}

qsub -N nanomonsv_get_PacBio -hold_jid nanomonsv_parse_PacBio $PWD/script/nanomonsv_get.sh \
$PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam \
$PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam \
$PWD/output/nanomonsv/COLO829_T_PacBio/COLO829_T_PacBio \
$PWD/output/nanomonsv/COLO829_R_PacBio/COLO829_R_PacBio \
${REFERENCE} ${CONTROL_PANEL_PREFIX}

qsub -N nanomonsv_get_kataoka -hold_jid nanomonsv_parse_kataoka $PWD/script/nanomonsv_get.sh \
$PWD/output/minimap2/COLO829/COLO829.aligned.bam \
$PWD/output/minimap2/COLO829BL/COLO829BL.aligned.bam \
$PWD/output/nanomonsv/COLO829/COLO829 \
$PWD/output/nanomonsv/COLO829BL/COLO829BL \
${REFERENCE} ${CONTROL_PANEL_PREFIX}

# nanomonsv-filt
qsub -N nanomonsv_filt_Nanopore -hold_jid nanomonsv_get_Nanopore $PWD/script/nanomonsv_filt.sh \
$PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore.nanomonsv.result.txt \
$PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore.nanomonsv.result.vcf \
$PWD/output/filt/nanomonsv/COLO829_T_Nanopore/

qsub -N nanomonsv_filt_PacBio -hold_jid nanomonsv_get_PacBio $PWD/script/nanomonsv_filt.sh \
$PWD/output/nanomonsv/COLO829_T_PacBio/COLO829_T_PacBio.nanomonsv.result.txt \
$PWD/output/nanomonsv/COLO829_T_PacBio/COLO829_T_PacBio.nanomonsv.result.vcf \
$PWD/output/filt/nanomonsv/COLO829_T_PacBio/

qsub -N nanomonsv_filt_kataoka -hold_jid nanomonsv_get_kataoka $PWD/script/nanomonsv_filt.sh \
$PWD/output/nanomonsv/COLO829/COLO829.nanomonsv.result.txt \
$PWD/output/nanomonsv/COLO829/COLO829.nanomonsv.result.vcf \
$PWD/output/filt/nanomonsv/COLO829/

# delly
qsub -N delly_Nanopore $PWD/script/delly.sh \
$PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam \
$PWD/output/delly/COLO829_T_Nanopore/COLO829_T_Nanopore.bcf \
${REFERENCE}

qsub -N delly_Nanopore $PWD/script/delly.sh \
$PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam \
$PWD/output/delly/COLO829_R_Nanopore/COLO829_R_Nanopore.bcf \
${REFERENCE}

qsub -N delly_PacBio $PWD/script/delly.sh \
$PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam \
$PWD/output/delly/COLO829_T_PacBio/COLO829_T_PacBio.bcf \
${REFERENCE}

qsub -N delly_PacBio $PWD/script/delly.sh \
$PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam \
$PWD/output/delly/COLO829_R_PacBio/COLO829_R_PacBio.bcf \
${REFERENCE}

# delly-filt
qsub -N delly_filt_Nanopore -hold_jid delly_Nanopore $PWD/script/delly_filt.sh \
$PWD/output/delly/COLO829_T_Nanopore/COLO829_T_Nanopore.bcf \
$PWD/output/delly/COLO829_R_Nanopore/COLO829_R_Nanopore.bcf \
$PWD/output/filt/delly/COLO829_T_Nanopore/

qsub -N delly_filt_PacBio -hold_jid delly_PacBio $PWD/script/delly_filt.sh \
$PWD/output/delly/COLO829_T_PacBio/COLO829_T_PacBio.bcf \
$PWD/output/delly/COLO829_R_PacBio/COLO829_R_PacBio.bcf \
$PWD/output/filt/delly/COLO829_T_PacBio/

# sniffles2
qsub -N sniffles2_Nanopore $PWD/script/sniffles2.sh $PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam $PWD/output/sniffles2/COLO829_T_Nanopore/COLO829_T_Nanopore.vcf
qsub -N sniffles2_Nanopore $PWD/script/sniffles2.sh $PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam $PWD/output/sniffles2/COLO829_R_Nanopore/COLO829_R_Nanopore.vcf
qsub -N sniffles2_PacBio $PWD/script/sniffles2.sh $PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam $PWD/output/sniffles2/COLO829_T_PacBio/COLO829_T_PacBio.vcf
qsub -N sniffles2_PacBio $PWD/script/sniffles2.sh $PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam $PWD/output/sniffles2/COLO829_R_PacBio/COLO829_R_PacBio.vcf

# sniffles2-filt
qsub -N sniffles2_filt_Nanopore -hold_jid sniffles2_Nanopore $PWD/script/sniffles2_filt.sh \
$PWD/output/sniffles2/COLO829_T_Nanopore/COLO829_T_Nanopore.vcf \
$PWD/output/sniffles2/COLO829_R_Nanopore/COLO829_R_Nanopore.vcf \
$PWD/output/filt/sniffles2/COLO829_T_Nanopore/

qsub -N sniffles2_filt_PacBio -hold_jid sniffles2_PacBio $PWD/script/sniffles2_filt.sh \
$PWD/output/sniffles2/COLO829_T_PacBio/COLO829_T_PacBio.vcf \
$PWD/output/sniffles2/COLO829_R_PacBio/COLO829_R_PacBio.vcf \
$PWD/output/filt/sniffles2/COLO829_T_PacBio/

# cutesv
qsub -N cutesv_Nanopore $PWD/script/cutesv.sh \
$PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam \
$PWD/output/cutesv/COLO829_T_Nanopore/COLO829_T_Nanopore.vcf \
${REFERENCE}

qsub -N cutesv_Nanopore $PWD/script/cutesv.sh \
$PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam \
$PWD/output/cutesv/COLO829_R_Nanopore/COLO829_R_Nanopore.vcf \
${REFERENCE}

qsub -N cutesv_PacBio $PWD/script/cutesv.sh \
$PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam \
$PWD/output/cutesv/COLO829_T_PacBio/COLO829_T_PacBio.vcf \
${REFERENCE}

qsub -N cutesv_PacBio $PWD/script/cutesv.sh \
$PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam \
$PWD/output/cutesv/COLO829_R_PacBio/COLO829_R_PacBio.vcf \
${REFERENCE}

# cutesv-filt
qsub -N cutesv_filt_Nanopore -hold_jid cutesv_Nanopore $PWD/script/cutesv_filt.sh \
$PWD/output/cutesv/COLO829_T_Nanopore/COLO829_T_Nanopore.vcf \
$PWD/output/cutesv/COLO829_R_Nanopore/COLO829_R_Nanopore.vcf \
$PWD/output/filt/cutesv/COLO829_T_Nanopore/

qsub -N cutesv_filt_PacBio -hold_jid cutesv_PacBio $PWD/script/cutesv_filt.sh \
$PWD/output/cutesv/COLO829_T_PacBio/COLO829_T_PacBio.vcf \
$PWD/output/cutesv/COLO829_R_PacBio/COLO829_R_PacBio.vcf \
$PWD/output/filt/cutesv/COLO829_T_PacBio/

# camphor_svcall
qsub -N camphor_svcall_Nanopore $PWD/script/camphor_svcall.sh $PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam $PWD/output/camphor/COLO829_T_Nanopore ${REFERENCE}
qsub -N camphor_svcall_Nanopore $PWD/script/camphor_svcall.sh $PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam $PWD/output/camphor/COLO829_R_Nanopore ${REFERENCE}
qsub -N camphor_svcall_PacBio $PWD/script/camphor_svcall.sh $PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam $PWD/output/camphor/COLO829_T_PacBio ${REFERENCE}
qsub -N camphor_svcall_PacBio $PWD/script/camphor_svcall.sh $PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam $PWD/output/camphor/COLO829_R_PacBio ${REFERENCE}

# camphor_somatic
qsub -N camphor_Nanopore -hold_jid camphor_svcall_Nanopore $PWD/script/camphor_comparision.sh \
    $PWD/output/camphor/COLO829_T_Nanopore \
    $PWD/output/camphor/COLO829_R_Nanopore \
    $PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam \
    $PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam \
    $PWD/output/fastq/COLO829_T_Nanopore/S.fastq \
    $PWD/output/camphor/COLO829_T_Nanopore

qsub -N camphor_PacBio -hold_jid camphor_svcall_PacBio $PWD/script/camphor_comparision.sh \
    $PWD/output/camphor/COLO829_T_PacBio \
    $PWD/output/camphor/COLO829_R_PacBio \
    $PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam \
    $PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam \
    $PWD/output/fastq/COLO829_T_PacBio/S.fastq \
    $PWD/output/camphor/COLO829_T_PacBio

# camphor-filt
qsub -N camphor_filt_Nanopore -hold_jid camphor_Nanopore $PWD/script/camphor_filt.sh \
$PWD/output/camphor/COLO829_T_Nanopore/somatic_SV.vcf \
$PWD/output/filt/camphor/COLO829_T_Nanopore/

qsub -N camphor_filt_PacBio -hold_jid camphor_PacBio $PWD/script/camphor_filt.sh \
$PWD/output/camphor/COLO829_T_PacBio/somatic_SV.vcf \
$PWD/output/filt/camphor/COLO829_T_PacBio/

# SVIM
qsub -N svim_Nanopore $PWD/script/svim.sh \
$PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam \
$PWD/output/svim/COLO829_T_Nanopore/ \
${REFERENCE}

qsub -N svim_Nanopore $PWD/script/svim.sh \
$PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam \
$PWD/output/svim/COLO829_R_Nanopore/ \
${REFERENCE}

qsub -N svim_PacBio $PWD/script/svim.sh \
$PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam \
$PWD/output/svim/COLO829_T_PacBio/ \
${REFERENCE}

qsub -N svim_PacBio $PWD/script/svim.sh \
$PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam \
$PWD/output/svim/COLO829_R_PacBio/ \
${REFERENCE}

# svim-filt
qsub -N svim_filt_Nanopore -hold_jid svim_Nanopore $PWD/script/svim_filt.sh \
$PWD/output/svim/COLO829_T_Nanopore/variants.vcf \
$PWD/output/svim/COLO829_R_Nanopore/variants.vcf \
$PWD/output/filt/svim/COLO829_T_Nanopore/

qsub -N svim_filt_PacBio -hold_jid svim_PacBio $PWD/script/svim_filt.sh \
$PWD/output/svim/COLO829_T_PacBio/variants.vcf \
$PWD/output/svim/COLO829_R_PacBio/variants.vcf \
$PWD/output/filt/svim/COLO829_T_PacBio/

# savana
qsub -N savana_Nanopore $PWD/script/savana.sh \
$PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam \
$PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam \
$PWD/output/savana/COLO829_T_Nanopore/ \
${REFERENCE}

qsub -N savana_PacBio $PWD/script/savana.sh \
$PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam \
$PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam \
$PWD/output/savana/COLO829_T_PacBio/ \
${REFERENCE}

# savana-filt
qsub -N savana_filt_Nanopore -hold_jid savana_Nanopore $PWD/script/savana_filt.sh \
$PWD/output/savana/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.somatic.sv_breakpoints.strict.vcf \
$PWD/output/filt/savana/COLO829_T_Nanopore.strict/

qsub -N savana_filt_Nanopore -hold_jid savana_Nanopore $PWD/script/savana_filt.sh \
$PWD/output/savana/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.somatic.sv_breakpoints.lenient.vcf \
$PWD/output/filt/savana/COLO829_T_Nanopore.lenient/

qsub -N savana_filt_PacBio -hold_jid savana_PacBio $PWD/script/savana_filt.sh \
$PWD/output/savana/COLO829_T_PacBio/COLO829_T_PacBio.aligned.somatic.sv_breakpoints.strict.vcf \
$PWD/output/filt/savana/COLO829_T_PacBio.strict/

qsub -N savana_filt_PacBio -hold_jid savana_PacBio $PWD/script/savana_filt.sh \
$PWD/output/savana/COLO829_T_PacBio/COLO829_T_PacBio.aligned.somatic.sv_breakpoints.lenient.vcf \
$PWD/output/filt/savana/COLO829_T_PacBio.lenient/

# 2023.8.8 savana 1.0.3 追加
REFERENCE=/home/aiokada/resources/database/GRCh38.d1.vd1/GRCh38.d1.vd1.fa

qsub -N savana_Nanopore $PWD/script/savana1.0.3.sh \
$PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam \
$PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam \
$PWD/output/savana1.0.3/COLO829_T_Nanopore/ \
${REFERENCE}

# Nanoporeに10日かかったので未実施
#qsub -N savana_PacBio $PWD/script/savana1.0.3.sh \
#$PWD/output/minimap2/COLO829_T_PacBio/COLO829_T_PacBio.aligned.bam \
#$PWD/output/minimap2/COLO829_R_PacBio/COLO829_R_PacBio.aligned.bam \
#$PWD/output/savana1.0.3/COLO829_T_PacBio/ \
#${REFERENCE}

qsub -N savana_filt_Nanopore -hold_jid savana_Nanopore $PWD/script/savana1.0.3_filt_dev.sh \
$PWD/output/savana1.0.3/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.sv_breakpoints.vcf \
$PWD/output/filt/savana1.0.3/COLO829_T_Nanopore/

#qsub -N savana_filt_PacBio -hold_jid savana_PacBio $PWD/script/savana1.0.3_filt_dev.sh \
#$PWD/output/savana1.0.3/COLO829_T_PacBio/COLO829_T_PacBio.aligned.sv_breakpoints.vcf \
#$PWD/output/filt/savana1.0.3/COLO829_T_PacBio/

