#! /usr/vin/env python

import sys, csv

count_summary = sys.argv[1]
ratio_summary = sys.argv[2]

from summarize_detection_module import novel_sv_svtype_count
from summarize_detection_module import summarize_benchmark_svtype_detection

input_file_dir = "/home/aiokada/sandbox/nanomonsv_benchmark/output"
nanomonsv_detected_info_Arora = summarize_benchmark_svtype_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Arora_2019.txt")
nanomonsv_detected_info_Valle_Inclan = summarize_benchmark_svtype_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Valle-Inclan_2020.txt")
nanomonsv_novel_info_Arora, nanomonsv_novel_info_Valle_Inclan = novel_sv_svtype_count(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.benchmark.result.txt")

sniffles2_detected_info_Arora = summarize_benchmark_svtype_detection(input_file_dir + "/sniffles2/benchmark/sniffles2_sv.Arora_2019.txt")
sniffles2_detected_info_Valle_Inclan = summarize_benchmark_svtype_detection(input_file_dir + "/sniffles2/benchmark/sniffles2_sv.Valle-Inclan_2020.txt")
sniffles2_novel_info_Arora, sniffles2_novel_info_Valle_Inclan = novel_sv_svtype_count(input_file_dir + "/sniffles2/benchmark/sniffles2_sv.benchmark.result.txt")

delly_detected_info_Arora = summarize_benchmark_svtype_detection(input_file_dir + "/delly/benchmark/delly_sv.Arora_2019.txt")
delly_detected_info_Valle_Inclan = summarize_benchmark_svtype_detection(input_file_dir + "/delly/benchmark/delly_sv.Valle-Inclan_2020.txt")
delly_novel_info_Arora, delly_novel_info_Valle_Inclan = novel_sv_svtype_count(input_file_dir + "/delly/benchmark/delly_sv.benchmark.result.txt")

cutesv_detected_info_Arora = summarize_benchmark_svtype_detection(input_file_dir + "/cutesv/benchmark/cutesv_sv.Arora_2019.txt")
cutesv_detected_info_Valle_Inclan = summarize_benchmark_svtype_detection(input_file_dir + "/cutesv/benchmark/cutesv_sv.Valle-Inclan_2020.txt")
cutesv_novel_info_Arora, cutesv_novel_info_Valle_Inclan = novel_sv_svtype_count(input_file_dir + "/cutesv/benchmark/cutesv_sv.benchmark.result.txt")

camphor_detected_info_Arora = summarize_benchmark_svtype_detection(input_file_dir + "/camphor/benchmark/camphor_sv.Arora_2019.txt")
camphor_detected_info_Valle_Inclan = summarize_benchmark_svtype_detection(input_file_dir + "/camphor/benchmark/camphor_sv.Valle-Inclan_2020.txt")
camphor_novel_info_Arora, camphor_novel_info_Valle_Inclan = novel_sv_svtype_count(input_file_dir + "/camphor/benchmark/camphor_sv.benchmark.result.txt")

svim_detected_info_Arora = summarize_benchmark_svtype_detection(input_file_dir + "/svim/benchmark/svim_sv.Arora_2019.txt")
svim_detected_info_Valle_Inclan = summarize_benchmark_svtype_detection(input_file_dir + "/svim/benchmark/svim_sv.Valle-Inclan_2020.txt")
svim_novel_info_Arora, svim_novel_info_Valle_Inclan = novel_sv_svtype_count(input_file_dir + "/svim/benchmark/svim_sv.benchmark.result.txt")

savana_detected_info_Arora = summarize_benchmark_svtype_detection(input_file_dir + "/savana/benchmark/savana_sv.Arora_2019.txt")
savana_detected_info_Valle_Inclan = summarize_benchmark_svtype_detection(input_file_dir + "/savana/benchmark/savana_sv.Valle-Inclan_2020.txt")
savana_novel_info_Arora, savana_novel_info_Valle_Inclan = novel_sv_svtype_count(input_file_dir + "/savana/benchmark/savana_sv.benchmark.result.txt")

def print_summary(dataset, benchmark, detected_info, novel_info, hout):
    for svtype in ["BND", "DEL", "INS/DUP", "INV", "other"]:
        print('\t'.join([dataset, benchmark, svtype, "Detected", str(detected_info[svtype]["count_detected"])]), file = hout)
        print('\t'.join([dataset, benchmark, svtype, "Not detected", str(detected_info[svtype]["count_nondetected"])]), file = hout)
        print('\t'.join([dataset, benchmark, svtype, "New", str(novel_info[svtype])]), file = hout)

hout = open(count_summary, 'w')
print('\t'.join(["Dataset", "Benchmark", "SV_Type", "Class", "Count"]), file = hout)

print_summary("nanomonsv", "Arora_2019", nanomonsv_detected_info_Arora, nanomonsv_novel_info_Arora, hout)
print_summary("nanomonsv", "Valle_Inclan_2020", nanomonsv_detected_info_Valle_Inclan, nanomonsv_novel_info_Valle_Inclan, hout)

print_summary("sniffles2", "Arora_2019", sniffles2_detected_info_Arora, sniffles2_novel_info_Arora, hout)
print_summary("sniffles2", "Valle_Inclan_2020", sniffles2_detected_info_Valle_Inclan, sniffles2_novel_info_Valle_Inclan, hout)

print_summary("delly", "Arora_2019", delly_detected_info_Arora, delly_novel_info_Arora, hout)
print_summary("delly", "Valle_Inclan_2020", delly_detected_info_Valle_Inclan, delly_novel_info_Valle_Inclan, hout)

print_summary("cutesv", "Arora_2019", cutesv_detected_info_Arora, cutesv_novel_info_Arora, hout)
print_summary("cutesv", "Valle_Inclan_2020", cutesv_detected_info_Valle_Inclan, cutesv_novel_info_Valle_Inclan, hout)

print_summary("camphor", "Arora_2019", camphor_detected_info_Arora, camphor_novel_info_Arora, hout)
print_summary("camphor", "Valle_Inclan_2020", camphor_detected_info_Valle_Inclan, camphor_novel_info_Valle_Inclan, hout)

print_summary("svim", "Arora_2019", svim_detected_info_Arora, svim_novel_info_Arora, hout)
print_summary("svim", "Valle_Inclan_2020", svim_detected_info_Valle_Inclan, svim_novel_info_Valle_Inclan, hout)

print_summary("savana", "Arora_2019", savana_detected_info_Arora, savana_novel_info_Arora, hout)
print_summary("savana", "Valle_Inclan_2020", savana_detected_info_Valle_Inclan, savana_novel_info_Valle_Inclan, hout)
hout.close()


def print_ratio(dataset, benchmark, detected_info, novel_info, hout):
    for svtype in ["BND", "DEL", "INS/DUP", "INV"]:
        precision = float(detected_info[svtype]["count_detected"]) / float(detected_info[svtype]["count_detected"] + novel_info[svtype])
        recall = float(detected_info[svtype]["count_detected"]) / float(detected_info[svtype]["count_detected"] + detected_info[svtype]["count_nondetected"])
        print('\t'.join([dataset, benchmark, svtype, str(precision), str(recall)]), file = hout)

hout = open(ratio_summary, 'w')
print('\t'.join(["Dataset", "Benchmark", "SV_Type", "Precision", "Recall"]), file = hout)

print_ratio("nanomonsv", "Arora_2019", nanomonsv_detected_info_Arora, nanomonsv_novel_info_Arora, hout)
print_ratio("nanomonsv", "Valle_Inclan_2020", nanomonsv_detected_info_Valle_Inclan, nanomonsv_novel_info_Valle_Inclan, hout)

print_ratio("sniffles2", "Arora_2019", sniffles2_detected_info_Arora, sniffles2_novel_info_Arora, hout)
print_ratio("sniffles2", "Valle_Inclan_2020", sniffles2_detected_info_Valle_Inclan, sniffles2_novel_info_Valle_Inclan, hout)

print_ratio("delly", "Arora_2019", delly_detected_info_Arora, delly_novel_info_Arora, hout)
print_ratio("delly", "Valle_Inclan_2020", delly_detected_info_Valle_Inclan, delly_novel_info_Valle_Inclan, hout)

print_ratio("cutesv", "Arora_2019", cutesv_detected_info_Arora, cutesv_novel_info_Arora, hout)
print_ratio("cutesv", "Valle_Inclan_2020", cutesv_detected_info_Valle_Inclan, cutesv_novel_info_Valle_Inclan, hout)

print_ratio("camphor", "Arora_2019", camphor_detected_info_Arora, camphor_novel_info_Arora, hout)
print_ratio("camphor", "Valle_Inclan_2020", camphor_detected_info_Valle_Inclan, camphor_novel_info_Valle_Inclan, hout)

print_ratio("svim", "Arora_2019", svim_detected_info_Arora, svim_novel_info_Arora, hout)
print_ratio("svim", "Valle_Inclan_2020", svim_detected_info_Valle_Inclan, svim_novel_info_Valle_Inclan, hout)

print_ratio("savana", "Arora_2019", savana_detected_info_Arora, savana_novel_info_Arora, hout)
print_ratio("savana", "Valle_Inclan_2020", savana_detected_info_Valle_Inclan, savana_novel_info_Valle_Inclan, hout)
hout.close()

