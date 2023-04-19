#! /usr/vin/env python

import sys, csv

count_summary = sys.argv[1]
ratio_summary = sys.argv[2]

from summarize_detection_module import novel_sv_count
from summarize_detection_module import summarize_benchmark_detection

Valle_Inclan_ONT_count_detected_Arora, Valle_Inclan_ONT_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.nanomonsv.Arora_2019.txt")
Valle_Inclan_ONT_count_detected_Valle_Inclan, Valle_Inclan_ONT_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.nanomonsv.Valle-Inclan_2020.txt")
Valle_Inclan_ONT_count_novel_Arora, Valle_Inclan_ONT_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.nanomonsv.annot.filt.sp.benchmark.result.txt")

Valle_Inclan_PBS_count_detected_Arora, Valle_Inclan_PBS_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_PacBio.nanomonsv.Arora_2019.txt")
Valle_Inclan_PBS_count_detected_Valle_Inclan, Valle_Inclan_PBS_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_PacBio.nanomonsv.Valle-Inclan_2020.txt")
Valle_Inclan_PBS_count_novel_Arora, Valle_Inclan_PBS_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_PacBio.nanomonsv.annot.filt.sp.benchmark.result.txt")

Valle_Inclan_ONT_NC_count_detected_Arora, Valle_Inclan_ONT_NC_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore_no_control.nanomonsv.Arora_2019.txt")
Valle_Inclan_ONT_NC_count_detected_Valle_Inclan, Valle_Inclan_ONT_NC_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore_no_control.nanomonsv.Valle-Inclan_2020.txt")
Valle_Inclan_ONT_NC_count_novel_Arora, Valle_Inclan_ONT_NC_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore_no_control.nanomonsv.annot.filt.sp.benchmark.result.txt")

Valle_Inclan_PBS_NC_count_detected_Arora, Valle_Inclan_PBS_NC_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_PacBio_no_control.nanomonsv.Arora_2019.txt")
Valle_Inclan_PBS_NC_count_detected_Valle_Inclan, Valle_Inclan_PBS_NC_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_PacBio_no_control.nanomonsv.Valle-Inclan_2020.txt")
Valle_Inclan_PBS_NC_count_novel_Arora, Valle_Inclan_PBS_NC_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_PacBio_no_control.nanomonsv.annot.filt.sp.benchmark.result.txt")

hout = open(count_summary, 'w')

print('\t'.join(["Dataset", "ControlPanel", "Benchmark", "Class", "Count"]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "T", "Arora_2019", "Detected", str(Valle_Inclan_ONT_count_detected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "T", "Arora_2019", "Not detected", str(Valle_Inclan_ONT_count_nondetected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "T", "Arora_2019", "New", str(Valle_Inclan_ONT_count_novel_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "T", "Valle_Inclan_2020", "Detected", str(Valle_Inclan_ONT_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "T", "Valle_Inclan_2020", "Not detected", str(Valle_Inclan_ONT_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "T", "Valle_Inclan_2020", "New", str(Valle_Inclan_ONT_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["Valle_Inclan_PBS", "T", "Arora_2019", "Detected", str(Valle_Inclan_PBS_count_detected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "T", "Arora_2019", "Not detected", str(Valle_Inclan_PBS_count_nondetected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "T", "Arora_2019", "New", str(Valle_Inclan_PBS_count_novel_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "T", "Valle_Inclan_2020", "Detected", str(Valle_Inclan_PBS_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "T", "Valle_Inclan_2020", "Not detected", str(Valle_Inclan_PBS_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "T", "Valle_Inclan_2020", "New", str(Valle_Inclan_PBS_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["Valle_Inclan_ONT", "F", "Arora_2019", "Detected", str(Valle_Inclan_ONT_NC_count_detected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "F", "Arora_2019", "Not detected", str(Valle_Inclan_ONT_NC_count_nondetected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "F", "Arora_2019", "New", str(Valle_Inclan_ONT_NC_count_novel_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "F", "Valle_Inclan_2020", "Detected", str(Valle_Inclan_ONT_NC_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "F", "Valle_Inclan_2020", "Not detected", str(Valle_Inclan_ONT_NC_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "F", "Valle_Inclan_2020", "New", str(Valle_Inclan_ONT_NC_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["Valle_Inclan_PBS", "F", "Arora_2019", "Detected", str(Valle_Inclan_PBS_NC_count_detected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "F", "Arora_2019", "Not detected", str(Valle_Inclan_PBS_NC_count_nondetected_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "F", "Arora_2019", "New", str(Valle_Inclan_PBS_NC_count_novel_Arora)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "F", "Valle_Inclan_2020", "Detected", str(Valle_Inclan_PBS_NC_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "F", "Valle_Inclan_2020", "Not detected", str(Valle_Inclan_PBS_NC_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "F", "Valle_Inclan_2020", "New", str(Valle_Inclan_PBS_NC_count_novel_Valle_Inclan)]), file = hout)

hout.close()


hout = open(ratio_summary, 'w')
print('\t'.join(["Dataset", "ControlPanel", "Benchmark", "Precision", "Recall"]), file = hout)

print('\t'.join(["Valle_Inclan_ONT", "T", "Arora_2019", str(float(Valle_Inclan_ONT_count_detected_Arora) / float(Valle_Inclan_ONT_count_detected_Arora + Valle_Inclan_ONT_count_novel_Arora)),
    str(float(Valle_Inclan_ONT_count_detected_Arora) / float(Valle_Inclan_ONT_count_detected_Arora + Valle_Inclan_ONT_count_nondetected_Arora))]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "T", "Valle_Inclan_2020", str(float(Valle_Inclan_ONT_count_detected_Valle_Inclan) / float(Valle_Inclan_ONT_count_detected_Valle_Inclan + Valle_Inclan_ONT_count_novel_Valle_Inclan)),
    str(float(Valle_Inclan_ONT_count_detected_Valle_Inclan) / float(Valle_Inclan_ONT_count_detected_Valle_Inclan + Valle_Inclan_ONT_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["Valle_Inclan_PBS", "T", "Arora_2019", str(float(Valle_Inclan_PBS_count_detected_Arora) / float(Valle_Inclan_PBS_count_detected_Arora + Valle_Inclan_PBS_count_novel_Arora)),
    str(float(Valle_Inclan_PBS_count_detected_Arora) / float(Valle_Inclan_PBS_count_detected_Arora + Valle_Inclan_PBS_count_nondetected_Arora))]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "T", "Valle_Inclan_2020", str(float(Valle_Inclan_PBS_count_detected_Valle_Inclan) / float(Valle_Inclan_PBS_count_detected_Valle_Inclan + Valle_Inclan_PBS_count_novel_Valle_Inclan)),
    str(float(Valle_Inclan_PBS_count_detected_Valle_Inclan) / float(Valle_Inclan_PBS_count_detected_Valle_Inclan + Valle_Inclan_PBS_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["Valle_Inclan_ONT", "F", "Arora_2019", str(float(Valle_Inclan_ONT_NC_count_detected_Arora) / float(Valle_Inclan_ONT_NC_count_detected_Arora + Valle_Inclan_ONT_NC_count_novel_Arora)),
    str(float(Valle_Inclan_ONT_NC_count_detected_Arora) / float(Valle_Inclan_ONT_NC_count_detected_Arora + Valle_Inclan_ONT_NC_count_nondetected_Arora))]), file = hout)
print('\t'.join(["Valle_Inclan_ONT", "F", "Valle_Inclan_2020", str(float(Valle_Inclan_ONT_NC_count_detected_Valle_Inclan) / float(Valle_Inclan_ONT_NC_count_detected_Valle_Inclan + Valle_Inclan_ONT_NC_count_novel_Valle_Inclan)),
    str(float(Valle_Inclan_ONT_NC_count_detected_Valle_Inclan) / float(Valle_Inclan_ONT_NC_count_detected_Valle_Inclan + Valle_Inclan_ONT_NC_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["Valle_Inclan_PBS", "F", "Arora_2019", str(float(Valle_Inclan_PBS_NC_count_detected_Arora) / float(Valle_Inclan_PBS_NC_count_detected_Arora + Valle_Inclan_PBS_NC_count_novel_Arora)),
    str(float(Valle_Inclan_PBS_NC_count_detected_Arora) / float(Valle_Inclan_PBS_NC_count_detected_Arora + Valle_Inclan_PBS_NC_count_nondetected_Arora))]), file = hout)
print('\t'.join(["Valle_Inclan_PBS", "F", "Valle_Inclan_2020", str(float(Valle_Inclan_PBS_NC_count_detected_Valle_Inclan) / float(Valle_Inclan_PBS_NC_count_detected_Valle_Inclan + Valle_Inclan_PBS_NC_count_novel_Valle_Inclan)),
    str(float(Valle_Inclan_PBS_NC_count_detected_Valle_Inclan) / float(Valle_Inclan_PBS_NC_count_detected_Valle_Inclan + Valle_Inclan_PBS_NC_count_nondetected_Valle_Inclan))]), file = hout)

hout.close()

