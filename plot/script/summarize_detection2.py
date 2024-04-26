#! /usr/vin/env python

import sys, csv

count_summary = sys.argv[1]
ratio_summary = sys.argv[2]

from summarize_detection_module import novel_sv_count
from summarize_detection_module import summarize_benchmark_detection

input_file_dir = "/home/aiokada/sandbox/nanomonsv_benchmark/output"
nanomonsv_count_detected_Arora, nanomonsv_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Arora_2019.txt")
nanomonsv_count_detected_Valle_Inclan, nanomonsv_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Valle-Inclan_2020.txt")
nanomonsv_count_novel_Arora, nanomonsv_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.benchmark.result.txt")

sniffles2_count_detected_Arora, sniffles2_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/sniffles2/benchmark/sniffles2_sv.Arora_2019.txt")
sniffles2_count_detected_Valle_Inclan, sniffles2_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/sniffles2/benchmark/sniffles2_sv.Valle-Inclan_2020.txt")
sniffles2_count_novel_Arora, sniffles2_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/sniffles2/benchmark/sniffles2_sv.benchmark.result.txt")

delly_count_detected_Arora, delly_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/delly/benchmark/delly_sv.Arora_2019.txt")
delly_count_detected_Valle_Inclan, delly_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/delly/benchmark/delly_sv.Valle-Inclan_2020.txt")
delly_count_novel_Arora, delly_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/delly/benchmark/delly_sv.benchmark.result.txt")

cutesv_count_detected_Arora, cutesv_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/cutesv/benchmark/cutesv_sv.Arora_2019.txt")
cutesv_count_detected_Valle_Inclan, cutesv_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/cutesv/benchmark/cutesv_sv.Valle-Inclan_2020.txt")
cutesv_count_novel_Arora, cutesv_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/cutesv/benchmark/cutesv_sv.benchmark.result.txt")

camphor_count_detected_Arora, camphor_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/camphor/benchmark/camphor_sv.Arora_2019.txt")
camphor_count_detected_Valle_Inclan, camphor_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/camphor/benchmark/camphor_sv.Valle-Inclan_2020.txt")
camphor_count_novel_Arora, camphor_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/camphor/benchmark/camphor_sv.benchmark.result.txt")

svim_count_detected_Arora, svim_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/svim/benchmark/svim_sv.Arora_2019.txt")
svim_count_detected_Valle_Inclan, svim_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/svim/benchmark/svim_sv.Valle-Inclan_2020.txt")
svim_count_novel_Arora, svim_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/svim/benchmark/svim_sv.benchmark.result.txt")

savana_count_detected_Arora, savana_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/savana/benchmark/savana_sv.Arora_2019.txt")
savana_count_detected_Valle_Inclan, savana_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/savana/benchmark/savana_sv.Valle-Inclan_2020.txt")
savana_count_novel_Arora, savana_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/savana/benchmark/savana_sv.benchmark.result.txt")

hout = open(count_summary, 'w')

print('\t'.join(["Dataset", "Benchmark", "Class", "Count"]), file = hout)
print('\t'.join(["nanomonsv", "Arora_2019", "Detected", str(nanomonsv_count_detected_Arora)]), file = hout)
print('\t'.join(["nanomonsv", "Arora_2019", "Not detected", str(nanomonsv_count_nondetected_Arora)]), file = hout)
print('\t'.join(["nanomonsv", "Arora_2019", "New", str(nanomonsv_count_novel_Arora)]), file = hout)
print('\t'.join(["nanomonsv", "Valle_Inclan_2020", "Detected", str(nanomonsv_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["nanomonsv", "Valle_Inclan_2020", "Not detected", str(nanomonsv_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["nanomonsv", "Valle_Inclan_2020", "New", str(nanomonsv_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["sniffles2", "Arora_2019", "Detected", str(sniffles2_count_detected_Arora)]), file = hout)
print('\t'.join(["sniffles2", "Arora_2019", "Not detected", str(sniffles2_count_nondetected_Arora)]), file = hout)
print('\t'.join(["sniffles2", "Arora_2019", "New", str(sniffles2_count_novel_Arora)]), file = hout)
print('\t'.join(["sniffles2", "Valle_Inclan_2020", "Detected", str(sniffles2_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["sniffles2", "Valle_Inclan_2020", "Not detected", str(sniffles2_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["sniffles2", "Valle_Inclan_2020", "New", str(sniffles2_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["delly", "Arora_2019", "Detected", str(delly_count_detected_Arora)]), file = hout)
print('\t'.join(["delly", "Arora_2019", "Not detected", str(delly_count_nondetected_Arora)]), file = hout)
print('\t'.join(["delly", "Arora_2019", "New", str(delly_count_novel_Arora)]), file = hout)
print('\t'.join(["delly", "Valle_Inclan_2020", "Detected", str(delly_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["delly", "Valle_Inclan_2020", "Not detected", str(delly_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["delly", "Valle_Inclan_2020", "New", str(delly_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["cutesv", "Arora_2019", "Detected", str(cutesv_count_detected_Arora)]), file = hout)
print('\t'.join(["cutesv", "Arora_2019", "Not detected", str(cutesv_count_nondetected_Arora)]), file = hout)
print('\t'.join(["cutesv", "Arora_2019", "New", str(cutesv_count_novel_Arora)]), file = hout)
print('\t'.join(["cutesv", "Valle_Inclan_2020", "Detected", str(cutesv_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["cutesv", "Valle_Inclan_2020", "Not detected", str(cutesv_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["cutesv", "Valle_Inclan_2020", "New", str(cutesv_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["camphor", "Arora_2019", "Detected", str(camphor_count_detected_Arora)]), file = hout)
print('\t'.join(["camphor", "Arora_2019", "Not detected", str(camphor_count_nondetected_Arora)]), file = hout)
print('\t'.join(["camphor", "Arora_2019", "New", str(camphor_count_novel_Arora)]), file = hout)
print('\t'.join(["camphor", "Valle_Inclan_2020", "Detected", str(camphor_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["camphor", "Valle_Inclan_2020", "Not detected", str(camphor_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["camphor", "Valle_Inclan_2020", "New", str(camphor_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["svim", "Arora_2019", "Detected", str(svim_count_detected_Arora)]), file = hout)
print('\t'.join(["svim", "Arora_2019", "Not detected", str(svim_count_nondetected_Arora)]), file = hout)
print('\t'.join(["svim", "Arora_2019", "New", str(svim_count_novel_Arora)]), file = hout)
print('\t'.join(["svim", "Valle_Inclan_2020", "Detected", str(svim_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["svim", "Valle_Inclan_2020", "Not detected", str(svim_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["svim", "Valle_Inclan_2020", "New", str(svim_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["savana", "Arora_2019", "Detected", str(savana_count_detected_Arora)]), file = hout)
print('\t'.join(["savana", "Arora_2019", "Not detected", str(savana_count_nondetected_Arora)]), file = hout)
print('\t'.join(["savana", "Arora_2019", "New", str(savana_count_novel_Arora)]), file = hout)
print('\t'.join(["savana", "Valle_Inclan_2020", "Detected", str(savana_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["savana", "Valle_Inclan_2020", "Not detected", str(savana_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["savana", "Valle_Inclan_2020", "New", str(savana_count_novel_Valle_Inclan)]), file = hout)
hout.close()

hout = open(ratio_summary, 'w')
print('\t'.join(["Dataset", "Benchmark", "Precision", "Recall"]), file = hout)
print('\t'.join(["nanomonsv", "Arora_2019", str(float(nanomonsv_count_detected_Arora) / float(nanomonsv_count_detected_Arora + nanomonsv_count_novel_Arora)),
    str(float(nanomonsv_count_detected_Arora) / float(nanomonsv_count_detected_Arora + nanomonsv_count_nondetected_Arora))]), file = hout)
print('\t'.join(["nanomonsv", "Valle_Inclan_2020", str(float(nanomonsv_count_detected_Valle_Inclan) / float(nanomonsv_count_detected_Valle_Inclan + nanomonsv_count_novel_Valle_Inclan)),
    str(float(nanomonsv_count_detected_Valle_Inclan) / float(nanomonsv_count_detected_Valle_Inclan + nanomonsv_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["sniffles2", "Arora_2019", str(float(sniffles2_count_detected_Arora) / float(sniffles2_count_detected_Arora + sniffles2_count_novel_Arora)),
    str(float(sniffles2_count_detected_Arora) / float(sniffles2_count_detected_Arora + sniffles2_count_nondetected_Arora))]), file = hout)
print('\t'.join(["sniffles2", "Valle_Inclan_2020", str(float(sniffles2_count_detected_Valle_Inclan) / float(sniffles2_count_detected_Valle_Inclan + sniffles2_count_novel_Valle_Inclan)),
    str(float(sniffles2_count_detected_Valle_Inclan) / float(sniffles2_count_detected_Valle_Inclan + sniffles2_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["delly", "Arora_2019", str(float(delly_count_detected_Arora) / float(delly_count_detected_Arora + delly_count_novel_Arora)),
    str(float(delly_count_detected_Arora) / float(delly_count_detected_Arora + delly_count_nondetected_Arora))]), file = hout)
print('\t'.join(["delly", "Valle_Inclan_2020", str(float(delly_count_detected_Valle_Inclan) / float(delly_count_detected_Valle_Inclan + delly_count_novel_Valle_Inclan)),
    str(float(delly_count_detected_Valle_Inclan) / float(delly_count_detected_Valle_Inclan + delly_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["cutesv", "Arora_2019", str(float(cutesv_count_detected_Arora) / float(cutesv_count_detected_Arora + cutesv_count_novel_Arora)),
    str(float(cutesv_count_detected_Arora) / float(cutesv_count_detected_Arora + cutesv_count_nondetected_Arora))]), file = hout)
print('\t'.join(["cutesv", "Valle_Inclan_2020", str(float(cutesv_count_detected_Valle_Inclan) / float(cutesv_count_detected_Valle_Inclan + cutesv_count_novel_Valle_Inclan)),
    str(float(cutesv_count_detected_Valle_Inclan) / float(cutesv_count_detected_Valle_Inclan + cutesv_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["camphor", "Arora_2019", str(float(camphor_count_detected_Arora) / float(camphor_count_detected_Arora + camphor_count_novel_Arora)),
    str(float(camphor_count_detected_Arora) / float(camphor_count_detected_Arora + camphor_count_nondetected_Arora))]), file = hout)
print('\t'.join(["camphor", "Valle_Inclan_2020", str(float(camphor_count_detected_Valle_Inclan) / float(camphor_count_detected_Valle_Inclan + camphor_count_novel_Valle_Inclan)),
    str(float(camphor_count_detected_Valle_Inclan) / float(camphor_count_detected_Valle_Inclan + camphor_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["svim", "Arora_2019", str(float(svim_count_detected_Arora) / float(svim_count_detected_Arora + svim_count_novel_Arora)),
    str(float(svim_count_detected_Arora) / float(svim_count_detected_Arora + svim_count_nondetected_Arora))]), file = hout)
print('\t'.join(["svim", "Valle_Inclan_2020", str(float(svim_count_detected_Valle_Inclan) / float(svim_count_detected_Valle_Inclan + svim_count_novel_Valle_Inclan)),
    str(float(svim_count_detected_Valle_Inclan) / float(svim_count_detected_Valle_Inclan + svim_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["savana", "Arora_2019", str(float(savana_count_detected_Arora) / float(savana_count_detected_Arora + savana_count_novel_Arora)),
    str(float(savana_count_detected_Arora) / float(savana_count_detected_Arora + savana_count_nondetected_Arora))]), file = hout)
print('\t'.join(["savana", "Valle_Inclan_2020", str(float(savana_count_detected_Valle_Inclan) / float(savana_count_detected_Valle_Inclan + savana_count_novel_Valle_Inclan)),
    str(float(savana_count_detected_Valle_Inclan) / float(savana_count_detected_Valle_Inclan + savana_count_nondetected_Valle_Inclan))]), file = hout)
hout.close()

