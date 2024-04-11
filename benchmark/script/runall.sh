#! /usr/bin/env bash
source ~/conda/x64/etc/profile.d/conda.sh
conda activate nanomonsv_benchmark

set -eux

mkdir -p ../work
mkdir -p ../output

## SV files
nanomonsv_Nanopore=~/sandbox/benchmark_COLO829/output/nanomonsv/COLO829_T_Nanopore/COLO829_T_Nanopore.nanomonsv.result.txt
nanomonsv_PacBio=~/sandbox/benchmark_COLO829/output/nanomonsv/COLO829_T_PacBio/COLO829_T_PacBio.nanomonsv.result.txt
nanomonsv_kataoka=~/sandbox/benchmark_COLO829/output/nanomonsv/guppy_3.4.5/COLO829/COLO829.nanomonsv.result.txt
nanomonsv_Nanopore_no_control=~/sandbox/benchmark_COLO829/output/nanomonsv/COLO829_T_Nanopore_no_control/COLO829_T_Nanopore.nanomonsv.result.txt
nanomonsv_PacBio_no_control=~/sandbox/benchmark_COLO829/output/nanomonsv/COLO829_T_PacBio_no_control/COLO829_T_PacBio.nanomonsv.result.txt

sniffles2_sv=~/sandbox/benchmark_COLO829/output/filt/sniffles2/COLO829_T_Nanopore/sniffles_sv.rmdup.txt
delly_sv=~/sandbox/benchmark_COLO829/output/filt/delly/COLO829_T_Nanopore/delly_sv.rmdup.txt
cutesv_sv=~/sandbox/benchmark_COLO829/output/filt/cutesv/COLO829_T_Nanopore/cutesv_sv.rmdup.txt
camphor_sv=~/sandbox/benchmark_COLO829/output/filt/camphor/COLO829_T_Nanopore/camphor_sv.rmdup.txt
svim_sv=~/sandbox/benchmark_COLO829/output/filt/svim/COLO829_T_Nanopore/svim_sv.rmdup.txt
savana_strict_sv=~/sandbox/benchmark_COLO829/output/filt/savana/COLO829_T_Nanopore.strict/savana_sv.rmdup.txt
savana_lenient_sv=~/sandbox/benchmark_COLO829/output/filt/savana/COLO829_T_Nanopore.lenient/savana_sv.rmdup.txt

reference=~/resources/database/GRCh38.d1.vd1/GRCh38.d1.vd1.fa

## filter nanomonsv
cp ${nanomonsv_Nanopore} ../work/
cp ${nanomonsv_PacBio} ../work/
cp ${nanomonsv_kataoka} ../work/COLO829_T_kataoka.nanomonsv.result.txt
cp ${nanomonsv_Nanopore_no_control} ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.txt
cp ${nanomonsv_PacBio_no_control} ../work/COLO829_T_PacBio_no_control.nanomonsv.result.txt

python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.nanomonsv.result.txt ../work/COLO829_T_Nanopore.nanomonsv.result.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_PacBio.nanomonsv.result.txt ../work/COLO829_T_PacBio.nanomonsv.result.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_kataoka.nanomonsv.result.txt ../work/COLO829_T_kataoka.nanomonsv.result.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 3

python3 add_simple_repeat.py ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.txt ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_PacBio_no_control.nanomonsv.result.txt ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5

head -n 1 ../work/COLO829_T_Nanopore.nanomonsv.result.filt.txt > ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.nanomonsv.result.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt

head -n 1 ../work/COLO829_T_PacBio.nanomonsv.result.filt.txt > ../work/COLO829_T_PacBio.nanomonsv.result.filt.pass.txt
tail -n +2 ../work/COLO829_T_PacBio.nanomonsv.result.filt.txt | grep PASS >> ../work/COLO829_T_PacBio.nanomonsv.result.filt.pass.txt

head -n 1 ../work/COLO829_T_kataoka.nanomonsv.result.filt.txt > ../work/COLO829_T_kataoka.nanomonsv.result.filt.pass.txt
tail -n +2 ../work/COLO829_T_kataoka.nanomonsv.result.filt.txt | grep PASS >> ../work/COLO829_T_kataoka.nanomonsv.result.filt.pass.txt

head -n 1 ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.txt > ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.pass.txt

head -n 1 ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.txt > ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.pass.txt
tail -n +2 ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.txt | grep PASS >> ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.pass.txt

python3 add_repeat.py ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt ../db/gene.bed.gz ../db/simpleRepeat.bed.gz > ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt.tmp
python3 add_repeat.py ../work/COLO829_T_PacBio.nanomonsv.result.filt.pass.txt ../db/gene.bed.gz ../db/simpleRepeat.bed.gz > ../work/COLO829_T_PacBio.nanomonsv.result.filt.pass.txt.tmp
python3 add_repeat.py ../work/COLO829_T_kataoka.nanomonsv.result.filt.pass.txt ../db/gene.bed.gz ../db/simpleRepeat.bed.gz > ../work/COLO829_T_kataoka.nanomonsv.result.filt.pass.txt.tmp
python3 add_repeat.py ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.pass.txt ../db/gene.bed.gz ../db/simpleRepeat.bed.gz > ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.pass.txt.tmp
python3 add_repeat.py ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.pass.txt ../db/gene.bed.gz ../db/simpleRepeat.bed.gz > ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.pass.txt.tmp

nanomonsv insert_classify ../work/COLO829_T_Nanopore.nanomonsv.result.filt.pass.txt.tmp ../work/COLO829_T_Nanopore.nanomonsv.annot.result.txt  ${reference} --genome_id hg38
nanomonsv insert_classify ../work/COLO829_T_PacBio.nanomonsv.result.filt.pass.txt.tmp ../work/COLO829_T_PacBio.nanomonsv.annot.result.txt  ${reference} --genome_id hg38
nanomonsv insert_classify ../work/COLO829_T_kataoka.nanomonsv.result.filt.pass.txt.tmp ../work/COLO829_T_kataoka.nanomonsv.annot.result.txt  ${reference} --genome_id hg38
nanomonsv insert_classify ../work/COLO829_T_Nanopore_no_control.nanomonsv.result.filt.pass.txt.tmp ../work/COLO829_T_Nanopore_no_control.nanomonsv.annot.result.txt  ${reference} --genome_id hg38
nanomonsv insert_classify ../work/COLO829_T_PacBio_no_control.nanomonsv.result.filt.pass.txt.tmp ../work/COLO829_T_PacBio_no_control.nanomonsv.annot.result.txt  ${reference} --genome_id hg38

python3 final_filter2.py ../work/COLO829_T_Nanopore.nanomonsv.annot.result.txt ../db/COLO829.nanomonsv.review_YS.txt ../db/cancer_gene_census_20200505.csv > ../work/COLO829_T_Nanopore.nanomonsv.annot.filt.result.txt
python3 final_filter2.py ../work/COLO829_T_PacBio.nanomonsv.annot.result.txt ../db/COLO829.nanomonsv.review_YS.txt ../db/cancer_gene_census_20200505.csv > ../work/COLO829_T_PacBio.nanomonsv.annot.filt.result.txt
python3 final_filter2.py ../work/COLO829_T_kataoka.nanomonsv.annot.result.txt ../db/COLO829.nanomonsv.review_YS.txt ../db/cancer_gene_census_20200505.csv > ../work/COLO829_T_kataoka.nanomonsv.annot.filt.result.txt
python3 final_filter2.py ../work/COLO829_T_Nanopore_no_control.nanomonsv.annot.result.txt ../db/COLO829.nanomonsv.review_YS.txt ../db/cancer_gene_census_20200505.csv > ../work/COLO829_T_Nanopore_no_control.nanomonsv.annot.filt.result.txt
python3 final_filter2.py ../work/COLO829_T_PacBio_no_control.nanomonsv.annot.result.txt ../db/COLO829.nanomonsv.review_YS.txt ../db/cancer_gene_census_20200505.csv > ../work/COLO829_T_PacBio_no_control.nanomonsv.annot.filt.result.txt

## filter other tools
cp ${sniffles2_sv} ../work/COLO829_T_Nanopore.sniffles2_sv.rmdup.txt
cp ${delly_sv} ../work/COLO829_T_Nanopore.delly_sv.rmdup.txt
cp ${cutesv_sv} ../work/COLO829_T_Nanopore.cutesv_sv.rmdup.txt
cp ${camphor_sv} ../work/COLO829_T_Nanopore.camphor_sv.rmdup.txt
cp ${svim_sv} ../work/COLO829_T_Nanopore.svim_sv.rmdup.txt
cp ${savana_strict_sv} ../work/COLO829_T_Nanopore.savana_strict_sv.rmdup.txt
cp ${savana_lenient_sv} ../work/COLO829_T_Nanopore.savana_lenient_sv.rmdup.txt

python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.sniffles2_sv.rmdup.txt > ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.txt
python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.delly_sv.rmdup.txt > ../work/COLO829_T_Nanopore.delly_filtered.proc.txt
python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.cutesv_sv.rmdup.txt > ../work/COLO829_T_Nanopore.cutesv_filtered.proc.txt
python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.camphor_sv.rmdup.txt > ../work/COLO829_T_Nanopore.camphor_filtered.proc.txt
python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.svim_sv.rmdup.txt > ../work/COLO829_T_Nanopore.svim_filtered.proc.txt
python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.savana_strict_sv.rmdup.txt > ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.txt
python3 filt_sniffles_svim.py ../work/COLO829_T_Nanopore.savana_lenient_sv.rmdup.txt > ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.txt

python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.txt ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.delly_filtered.proc.txt ../work/COLO829_T_Nanopore.delly_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.cutesv_filtered.proc.txt ../work/COLO829_T_Nanopore.cutesv_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.camphor_filtered.proc.txt ../work/COLO829_T_Nanopore.camphor_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.svim_filtered.proc.txt ../work/COLO829_T_Nanopore.svim_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.txt ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5
python3 add_simple_repeat.py ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.txt ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.filt.txt ../db/simpleRepeat.bed.gz --min_tumor_support_read 5

head -n 1 ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.pass.txt

head -n 1 ../work/COLO829_T_Nanopore.delly_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.delly_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.delly_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.delly_filtered.proc.filt.pass.txt

head -n 1 ../work/COLO829_T_Nanopore.cutesv_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.cutesv_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.cutesv_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.cutesv_filtered.proc.filt.pass.txt

head -n 1 ../work/COLO829_T_Nanopore.camphor_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.camphor_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.camphor_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.camphor_filtered.proc.filt.pass.txt

head -n 1 ../work/COLO829_T_Nanopore.svim_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.svim_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.svim_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.svim_filtered.proc.filt.pass.txt

head -n 1 ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.filt.pass.txt

head -n 1 ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.filt.txt > ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.filt.pass.txt
tail -n +2 ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.filt.txt | grep PASS >> ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.filt.pass.txt

## benchmark compare
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.nanomonsv.annot.filt.result.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_Nanopore.nanomonsv.Arora_2019.txt ../output/COLO829_T_Nanopore.nanomonsv.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_PacBio.nanomonsv.annot.filt.result.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_PacBio.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_PacBio.nanomonsv.Arora_2019.txt ../output/COLO829_T_PacBio.nanomonsv.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_kataoka.nanomonsv.annot.filt.result.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_kataoka.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_kataoka.nanomonsv.Arora_2019.txt ../output/COLO829_T_kataoka.nanomonsv.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_Nanopore_no_control.nanomonsv.annot.filt.result.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore_no_control.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_Nanopore_no_control.nanomonsv.Arora_2019.txt ../output/COLO829_T_Nanopore_no_control.nanomonsv.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_PacBio_no_control.nanomonsv.annot.filt.result.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_PacBio_no_control.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_PacBio_no_control.nanomonsv.Arora_2019.txt ../output/COLO829_T_PacBio_no_control.nanomonsv.Valle-Inclan_2020.txt

python3 benchmark_compare.py ../work/COLO829_T_Nanopore.sniffles2_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.sniffles2.benchmark.result.txt ../output/COLO829_T_Nanopore.sniffles2.Arora_2019.txt ../output/COLO829_T_Nanopore.sniffles2.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.delly_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.delly.benchmark.result.txt ../output/COLO829_T_Nanopore.delly.Arora_2019.txt ../output/COLO829_T_Nanopore.delly.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.cutesv_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.cutesv.benchmark.result.txt ../output/COLO829_T_Nanopore.cutesv.Arora_2019.txt ../output/COLO829_T_Nanopore.cutesv.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.camphor_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.camphor.benchmark.result.txt ../output/COLO829_T_Nanopore.camphor.Arora_2019.txt ../output/COLO829_T_Nanopore.camphor.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.svim_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.svim.benchmark.result.txt ../output/COLO829_T_Nanopore.svim.Arora_2019.txt ../output/COLO829_T_Nanopore.svim.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.savana_strict_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.savana_strict.benchmark.result.txt ../output/COLO829_T_Nanopore.savana_strict.Arora_2019.txt ../output/COLO829_T_Nanopore.savana_strict.Valle-Inclan_2020.txt
python3 benchmark_compare.py ../work/COLO829_T_Nanopore.savana_lenient_filtered.proc.filt.pass.txt ../db/Arora_2019.txt ../db/Valle-Inclan_2020.txt ../output/COLO829_T_Nanopore.savana_lenient.benchmark.result.txt ../output/COLO829_T_Nanopore.savana_lenient.Arora_2019.txt ../output/COLO829_T_Nanopore.savana_lenient.Valle-Inclan_2020.txt

python3 summarize_detection.py ../output/benchmark.summary.count.txt ../output/benchmark.summary.ratio.txt
python3 summarize_detection2.py ../output/benchmark2.summary.count.txt ../output/benchmark2.summary.ratio.txt
python3 summarize_detection3.py ../output/benchmark3.summary.count.txt ../output/benchmark3.summary.ratio.txt
python3 summarize_detection4.py ../output/benchmark4.summary.count.txt ../output/benchmark4.summary.ratio.txt

python3 arora_supporting_reads.py ../output/COLO829_T_kataoka.nanomonsv.Arora_2019.txt > ../output/COLO829_T_kataoka.nanomonsv.Arora_2019.proc.txt
python3 make_supplementary_data_3.py  ../output/COLO829_T_kataoka.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_Nanopore.nanomonsv.annot.filt.sp.benchmark.result.txt ../output/COLO829_T_PacBio.nanomonsv.annot.filt.sp.benchmark.result.txt > ../output/SupplementaryData3.tsv

Rscript plot_count.R
Rscript plot_count_summary3.R
Rscript plot_count_summary4.R
Rscript read_num_change.R

Rscript venn_diagram.R
rm ../output/venn_*.png.*.log
