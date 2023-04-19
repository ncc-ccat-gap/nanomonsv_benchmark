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

Original_ONT_count_detected_Arora, Original_ONT_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_kataoka.nanomonsv.Arora_2019.txt")
Original_ONT_count_detected_Valle_Inclan, Original_ONT_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_kataoka.nanomonsv.Valle-Inclan_2020.txt")
Original_ONT_count_novel_Arora, Original_ONT_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_kataoka.nanomonsv.annot.filt.sp.benchmark.result.txt")

Valle_Inclan_ONT_count_detected_Arora, Valle_Inclan_ONT_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.nanomonsv.Arora_2019.txt")
Valle_Inclan_ONT_count_detected_Valle_Inclan, Valle_Inclan_ONT_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.nanomonsv.Valle-Inclan_2020.txt")
Valle_Inclan_ONT_count_novel_Arora, Valle_Inclan_ONT_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.nanomonsv.annot.filt.sp.benchmark.result.txt")

Valle_Inclan_PBS_count_detected_Arora, Valle_Inclan_PBS_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_PacBio.nanomonsv.Arora_2019.txt")
Valle_Inclan_PBS_count_detected_Valle_Inclan, Valle_Inclan_PBS_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_PacBio.nanomonsv.Valle-Inclan_2020.txt")
Valle_Inclan_PBS_count_novel_Arora, Valle_Inclan_PBS_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_PacBio.nanomonsv.annot.filt.sp.benchmark.result.txt")

hout = open(count_summary, 'w')

print('\t'.join(["Dataset", "Benchmark", "Class", "Count"]), file = hout)
print('\t'.join(["Original_ONT", "Arora_2019", "Detected", str(Original_ONT_count_detected_Arora)]), file = hout)
print('\t'.join(["Original_ONT", "Arora_2019", "Not detected", str(Original_ONT_count_nondetected_Arora)]), file = hout)
print('\t'.join(["Original_ONT", "Arora_2019", "New", str(Original_ONT_count_novel_Arora)]), file = hout)
print('\t'.join(["Original_ONT", "Valle_Inclan_2020", "Detected", str(Original_ONT_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["Original_ONT", "Valle_Inclan_2020", "Not detected", str(Original_ONT_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["Original_ONT", "Valle_Inclan_2020", "New", str(Original_ONT_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["Valle_Inclan_ONT", "Arora_2019", "Detected", str(Valle_Inclan_ONT_count_detected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "Arora_2019", "Not detected", str(Valle_Inclan_ONT_count_nondetected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "Arora_2019", "New", str(Valle_Inclan_ONT_count_novel_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "Valle_Inclan_2020", "Detected", str(Valle_Inclan_ONT_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "Valle_Inclan_2020", "Not detected", str(Valle_Inclan_ONT_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "Valle_Inclan_2020", "New", str(Valle_Inclan_ONT_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["Valle_Inclan_PBS", "Arora_2019", "Detected", str(Valle_Inclan_PBS_count_detected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "Arora_2019", "Not detected", str(Valle_Inclan_PBS_count_nondetected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "Arora_2019", "New", str(Valle_Inclan_PBS_count_novel_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "Valle_Inclan_2020", "Detected", str(Valle_Inclan_PBS_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "Valle_Inclan_2020", "Not detected", str(Valle_Inclan_PBS_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "Valle_Inclan_2020", "New", str(Valle_Inclan_PBS_count_novel_Valle_Inclan)]), file = hout)

hout.close()


hout = open(ratio_summary, 'w')
print('\t'.join(["Dataset", "Benchmark", "Precision", "Recall"]), file = hout)
print('\t'.join(["Original_ONT", "Arora_2019", str(float(Original_ONT_count_detected_Arora) / float(Original_ONT_count_detected_Arora + Original_ONT_count_novel_Arora)),
    str(float(Original_ONT_count_detected_Arora) / float(Original_ONT_count_detected_Arora + Original_ONT_count_nondetected_Arora))]), file = hout)
print('\t'.join(["Original_ONT", "Valle_Inclan_2020", str(float(Original_ONT_count_detected_Valle_Inclan) / float(Original_ONT_count_detected_Valle_Inclan + Original_ONT_count_novel_Valle_Inclan)),
    str(float(Original_ONT_count_detected_Valle_Inclan) / float(Original_ONT_count_detected_Valle_Inclan + Original_ONT_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["Valle_Inclan_ONT", "Arora_2019", str(float(Valle_Inclan_ONT_count_detected_Arora) / float(Valle_Inclan_ONT_count_detected_Arora + Valle_Inclan_ONT_count_novel_Arora)),
    str(float(Valle_Inclan_ONT_count_detected_Arora) / float(Valle_Inclan_ONT_count_detected_Arora + Valle_Inclan_ONT_count_nondetected_Arora))]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "Valle_Inclan_2020", str(float(Valle_Inclan_ONT_count_detected_Valle_Inclan) / float(Valle_Inclan_ONT_count_detected_Valle_Inclan + Valle_Inclan_ONT_count_novel_Valle_Inclan)),
    str(float(Valle_Inclan_ONT_count_detected_Valle_Inclan) / float(Valle_Inclan_ONT_count_detected_Valle_Inclan + Valle_Inclan_ONT_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["Valle_Inclan_PBS", "Arora_2019", str(float(Valle_Inclan_PBS_count_detected_Arora) / float(Valle_Inclan_PBS_count_detected_Arora + Valle_Inclan_PBS_count_novel_Arora)),
    str(float(Valle_Inclan_PBS_count_detected_Arora) / float(Valle_Inclan_PBS_count_detected_Arora + Valle_Inclan_PBS_count_nondetected_Arora))]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "Valle_Inclan_2020", str(float(Valle_Inclan_PBS_count_detected_Valle_Inclan) / float(Valle_Inclan_PBS_count_detected_Valle_Inclan + Valle_Inclan_PBS_count_novel_Valle_Inclan)),
    str(float(Valle_Inclan_PBS_count_detected_Valle_Inclan) / float(Valle_Inclan_PBS_count_detected_Valle_Inclan + Valle_Inclan_PBS_count_nondetected_Valle_Inclan))]), file = hout)
hout.close()

