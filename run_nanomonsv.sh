#! /usr/bin/env bash
source ~/conda/x64/etc/profile.d/conda.sh
conda activate nanomonsv_benchmark

set -eux

mkdir -p ../work
mkdir -p ../output

TUMOR_BAM=$PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam
NORMAL_BAM=$PWD/output/minimap2/COLO829_R_Nanopore/COLO829_R_Nanopore.aligned.bam

REFERENCE=/home/aiokada/resources/database/GRCh38.d1.vd1/GRCh38.d1.vd1.fa
CONTROL_PANEL_PREFIX=/home/aiokada/resources/control_panel/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control

# nanomonsv-parse
qsub -N nanomonsv_parse_Nanopore $PWD/script/nanomonsv_parse.sh $PWD/output/minimap2/COLO829_T_Nanopore/COLO829_T_Nanopore.aligned.bam $PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore
qsub -N nanomonsv_parse_Nanopore $PWD/script/nanomonsv_parse.sh ${NORMAL_BAM} $PWD/output/nanomonsv/COLO829_R_Nanopore/COLO829_R_Nanopore

# nanomonsv-get
qsub -N nanomonsv_get_Nanopore -hold_jid nanomonsv_parse_Nanopore $PWD/script/nanomonsv_get.sh \
${TUMOR_BAM} \
${NORMAL_BAM} \
$PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore \
$PWD/output/nanomonsv/COLO829_R_Nanopore/COLO829_R_Nanopore \
${REFERENCE} ${CONTROL_PANEL_PREFIX}

# nanomonsv-filt
qsub -N nanomonsv_filt_Nanopore -hold_jid nanomonsv_get_Nanopore $PWD/script/nanomonsv_filt.sh \
$PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore.nanomonsv.result.txt \
$PWD/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore.nanomonsv.result.vcf \
$PWD/output/filt/nanomonsv/COLO829_T_Nanopore/


## SV files
nanomonsv_Nanopore=~/sandbox/benchmark_COLO829/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore.nanomonsv.result.txt

## filter nanomonsv
cp ${nanomonsv_Nanopore} ../work/

python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.nanomonsv.result.txt ../work/COLO829_T_Nanopore.nanomonsv.result.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5

head -n 1 ../work/COLO829_T_Nanopore.nanomonsv.result.filt.txt > ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.nanomonsv.result.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt


python3 add_repeat.py ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt ../db/gene.bed.gz ../db/simpleRepeat.bed.gz > ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt.tmp

nanomonsv insert_classify ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt.tmp ../work/COLO829_T_Nanopore.nanomonsv.annot.result.txt  ${reference} --genome_id hg38

python3 final_filter2.py ../work/COLO829_T_Nanopore.nanomonsv.annot.result.txt ../db/COLO829.nanomonsv.review_YS.txt ../db/cancer_gene_census_20200505.csv > ../work/COLO829_T_Nanopore.nanomonsv.annot.filt.result.txt

## benchmark compare
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.nanomonsv.annot.filt.result.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_Nanopore.nanomonsv.Arora_2019.txt ../output/COLO829_T_Nanopore.nanomonsv.Valle-Inclan_2020.txt
