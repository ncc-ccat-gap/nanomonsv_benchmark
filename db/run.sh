#! /usr/bin/env bash
source ~/conda/x64/etc/profile.d/conda.sh
conda activate nanomonsv_benchmark

set -eux

if [ ! -f hg19ToHg38.over.chain.gz ]
then
    wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz
fi

python3 get_bed_key.py ./truthset_somaticSVs_COLO829.vcf > ./truthset_somaticSVs_COLO829.tmp.bed

chmod +x ../ucsc_tools/*
../ucsc_tools/liftOver  ./truthset_somaticSVs_COLO829.tmp.bed hg19ToHg38.over.chain.gz ./truthset_somaticSVs_COLO829.hg38.tmp.bed ./truthset_somaticSVs_COLO829.unmapped.tmp.bed 

python3 make_genomon1.py ./truthset_somaticSVs_COLO829.hg38.tmp.bed > ./Valle-Inclan_2020.txt
python3 make_genomon2.py ./COLO-829-NovaSeq--COLO-829BL-NovaSeq.sv.annotated.v6.somatic.high_confidence.final.bedpe > ./Arora_2019.txt

rm -rf ./truthset_somaticSVs_COLO829.tmp.bed
rm -rf ./truthset_somaticSVs_COLO829.hg38.tmp.bed
rm -rf ./truthset_somaticSVs_COLO829.unmapped.tmp.bed

if [ ! -f simpleRepeat.txt.gz ]
then
    wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/simpleRepeat.txt.gz
fi
zcat simpleRepeat.txt.gz | cut -f 2-4 | sort -k1,1 -k2,2n -k3,3n > simpleRepeat.bed
bgzip -c simpleRepeat.bed > simpleRepeat.bed.gz
tabix -p bed simpleRepeat.bed.gz

annot_utils gene --genome_id hg38 gene.bed.gz
