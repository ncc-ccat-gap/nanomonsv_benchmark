#! /usr/bin/env bash
source ~/conda/x64/etc/profile.d/conda.sh
conda activate nanomonsv_benchmark

set -eux

mkdir -p ../output

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
