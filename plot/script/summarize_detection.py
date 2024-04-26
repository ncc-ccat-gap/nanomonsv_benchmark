#! /usr/vin/env python

import sys, csv

count_summary = sys.argv[1]
ratio_summary = sys.argv[2]

from summarize_detection_module import novel_sv_count
from summarize_detection_module import summarize_benchmark_detection

"""
def novel_sv_count(sv_file):

    novel_count_arora = 0
    novel_count_valle_inclan = 0
    with open(sv_file, 'r') as hin:
        for F in csv.DictReader(hin, delimiter = '\t'):
            if F["Is_Arora"] == "NA": novel_count_arora = novel_count_arora + 1
            if F["Is_Valle_Inclan"] == "NA": novel_count_valle_inclan = novel_count_valle_inclan + 1

    return(novel_count_arora, novel_count_valle_inclan)


def summarize_benchmark_detection(benchmark_file):

    count_detected = 0
    count_nondetected = 0
    with open(benchmark_file, 'r') as hin:
        for line in hin:
            F = line.rstrip('\n').split('\t')
            if F[8] == "True": count_detected = count_detected + 1
            if F[8] == "False": count_nondetected = count_nondetected + 1

    return(count_detected, count_nondetected)
"""
input_file_dir = "/home/aiokada/sandbox/nanomonsv_benchmark/output_COLO829"
COLO829_count_detected_Arora, COLO829_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Arora_2019.txt")
COLO829_count_detected_Valle_Inclan, COLO829_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Valle-Inclan_2020.txt")
COLO829_count_novel_Arora, COLO829_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.benchmark.result.txt")

input_file_dir = "/home/aiokada/sandbox/nanomonsv_benchmark/output_HCC1954"
HCC1954_count_detected_Arora, HCC1954_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Arora_2019.txt")
HCC1954_count_detected_Valle_Inclan, HCC1954_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Valle-Inclan_2020.txt")
HCC1954_count_novel_Arora, HCC1954_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.benchmark.result.txt")

input_file_dir = "/home/aiokada/sandbox/nanomonsv_benchmark/output_NCI-H2009"
NCI-H2009_count_detected_Arora, NCI-H2009_count_nondetected_Arora = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Arora_2019.txt")
NCI-H2009_count_detected_Valle_Inclan, NCI-H2009_count_nondetected_Valle_Inclan = summarize_benchmark_detection(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.Valle-Inclan_2020.txt")
NCI-H2009_count_novel_Arora, NCI-H2009_count_novel_Valle_Inclan = novel_sv_count(input_file_dir + "/nanomonsv/benchmark/nanomonsv_sv.benchmark.result.txt")

hout = open(count_summary, 'w')

print('\t'.join(["Dataset", "Benchmark", "Class", "Count"]), file = hout)
print('\t'.join(["COLO829", "Arora_2019", "Detected", str(COLO829_count_detected_Arora)]), file = hout)
print('\t'.join(["COLO829", "Arora_2019", "Not detected", str(COLO829_count_nondetected_Arora)]), file = hout)
print('\t'.join(["COLO829", "Arora_2019", "New", str(COLO829_count_novel_Arora)]), file = hout)
print('\t'.join(["COLO829", "Valle_Inclan_2020", "Detected", str(COLO829_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["COLO829", "Valle_Inclan_2020", "Not detected", str(COLO829_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["COLO829", "Valle_Inclan_2020", "New", str(COLO829_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["HCC1954", "Arora_2019", "Detected", str(HCC1954_count_detected_Arora)]), file = hout)
print('\t'.join(["HCC1954", "Arora_2019", "Not detected", str(HCC1954_count_nondetected_Arora)]), file = hout)
print('\t'.join(["HCC1954", "Arora_2019", "New", str(HCC1954_count_novel_Arora)]), file = hout)
print('\t'.join(["HCC1954", "Valle_Inclan_2020", "Detected", str(HCC1954_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["HCC1954", "Valle_Inclan_2020", "Not detected", str(HCC1954_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["HCC1954", "Valle_Inclan_2020", "New", str(HCC1954_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["NCI-H2009", "Arora_2019", "Detected", str(NCI-H2009_count_detected_Arora)]), file = hout)
print('\t'.join(["NCI-H2009", "Arora_2019", "Not detected", str(NCI-H2009_count_nondetected_Arora)]), file = hout)
print('\t'.join(["NCI-H2009", "Arora_2019", "New", str(NCI-H2009_count_novel_Arora)]), file = hout)
print('\t'.join(["NCI-H2009", "Valle_Inclan_2020", "Detected", str(NCI-H2009_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["NCI-H2009", "Valle_Inclan_2020", "Not detected", str(NCI-H2009_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["NCI-H2009", "Valle_Inclan_2020", "New", str(NCI-H2009_count_novel_Valle_Inclan)]), file = hout)

hout.close()


hout = open(ratio_summary, 'w')
print('\t'.join(["Dataset", "Benchmark", "Precision", "Recall"]), file = hout)
print('\t'.join(["COLO829", "Arora_2019", str(float(COLO829_count_detected_Arora) / float(COLO829_count_detected_Arora + COLO829_count_novel_Arora)),
    str(float(COLO829_count_detected_Arora) / float(COLO829_count_detected_Arora + COLO829_count_nondetected_Arora))]), file = hout)
print('\t'.join(["COLO829", "Valle_Inclan_2020", str(float(COLO829_count_detected_Valle_Inclan) / float(COLO829_count_detected_Valle_Inclan + COLO829_count_novel_Valle_Inclan)),
    str(float(COLO829_count_detected_Valle_Inclan) / float(COLO829_count_detected_Valle_Inclan + COLO829_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["HCC1954", "Arora_2019", str(float(HCC1954_count_detected_Arora) / float(HCC1954_count_detected_Arora + HCC1954_count_novel_Arora)),
    str(float(HCC1954_count_detected_Arora) / float(HCC1954_count_detected_Arora + HCC1954_count_nondetected_Arora))]), file = hout)
print('\t'.join(["HCC1954", "Valle_Inclan_2020", str(float(HCC1954_count_detected_Valle_Inclan) / float(HCC1954_count_detected_Valle_Inclan + HCC1954_count_novel_Valle_Inclan)),
    str(float(HCC1954_count_detected_Valle_Inclan) / float(HCC1954_count_detected_Valle_Inclan + HCC1954_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["NCI-H2009", "Arora_2019", str(float(NCI-H2009_count_detected_Arora) / float(NCI-H2009_count_detected_Arora + NCI-H2009_count_novel_Arora)),
    str(float(NCI-H2009_count_detected_Arora) / float(NCI-H2009_count_detected_Arora + NCI-H2009_count_nondetected_Arora))]), file = hout)
print('\t'.join(["NCI-H2009", "Valle_Inclan_2020", str(float(NCI-H2009_count_detected_Valle_Inclan) / float(NCI-H2009_count_detected_Valle_Inclan + NCI-H2009_count_novel_Valle_Inclan)),
    str(float(NCI-H2009_count_detected_Valle_Inclan) / float(NCI-H2009_count_detected_Valle_Inclan + NCI-H2009_count_nondetected_Valle_Inclan))]), file = hout)
hout.close()

