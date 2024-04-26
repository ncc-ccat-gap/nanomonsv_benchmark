#! /usr/bin/env bash
source ~/conda/x64/etc/profile.d/conda.sh
conda activate nanomonsv_benchmark_plot

set -eux

INPUT_FILE_DIR=/home/aiokada/sandbox/nanomonsv_benchmark/output
OUTPUT_DIR=../output
mkdir -p ${OUTPUT_DIR}

# summarize benchmark (Arora_2019)
python3 arora_supporting_reads.py \
  ${INPUT_FILE_DIR}/sniffles2/benchmark/sniffles2_sv.Arora_2019.txt \
> ${OUTPUT_DIR}/sniffles2_sv.Arora_2019.proc.txt

Rscript plot_COLO829.Arora_2019.SR_PE.R

# multiple samples
python3 make_supplementary_data_3.py \
  ${INPUT_FILE_DIR}/sniffles2/benchmark/sniffles2_sv.benchmark.result.txt \
  ${INPUT_FILE_DIR}/cutesv/benchmark/cutesv_sv.benchmark.result.txt \
  ${INPUT_FILE_DIR}/delly/benchmark/delly_sv.benchmark.result.txt \
  sniffles2 cutesv delly \
> ${OUTPUT_DIR}/SupplementaryData3.tsv

python3 summarize_detection.py ${OUTPUT_DIR}/benchmark.summary.count.txt ${OUTPUT_DIR}/benchmark.summary.ratio.txt
Rscript plot_benchmark_detection_count_summary.R
Rscript plot_benchmark_detection_ratio_summary.R
Rscript venn_diagram.R
rm ${OUTPUT_DIR}/venn_*.png.*.log

# multiple SV tools
python3 summarize_detection2.py ${OUTPUT_DIR}/benchmark2.summary.count.txt ${OUTPUT_DIR}/benchmark2.summary.ratio.txt
Rscript plot_benchmark_detection_ratio_summary2.R

python3 summarize_detection3.py ${OUTPUT_DIR}/benchmark3.summary.count.txt ${OUTPUT_DIR}/benchmark3.summary.ratio.txt
Rscript plot_benchmark_detection_ratio_summary3.R

Rscript plot_read_num_change.R

# control vs no control
python3 summarize_detection4.py ${OUTPUT_DIR}/benchmark4.summary.count.txt ${OUTPUT_DIR}/benchmark4.summary.ratio.txt
Rscript plot_benchmark_detection_ratio_summary4.R
