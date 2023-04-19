#! /usr/vin/env python

import sys, csv

count_summary = sys.argv[1]
ratio_summary = sys.argv[2]

from summarize_detection_module import novel_sv_count
from summarize_detection_module import summarize_benchmark_detection


nanomonsv_count_detected_Arora, nanomonsv_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.nanomonsv.Arora_2019.txt")
nanomonsv_count_detected_Valle_Inclan, nanomonsv_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.nanomonsv.Valle-Inclan_2020.txt")
nanomonsv_count_novel_Arora, nanomonsv_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.nanomonsv.annot.filt.sp.benchmark.result.txt")

sniffles2_count_detected_Arora, sniffles2_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.sniffles2.Arora_2019.txt")
sniffles2_count_detected_Valle_Inclan, sniffles2_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.sniffles2.Valle-Inclan_2020.txt")
sniffles2_count_novel_Arora, sniffles2_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.sniffles2.benchmark.result.txt")

delly_count_detected_Arora, delly_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.delly.Arora_2019.txt")
delly_count_detected_Valle_Inclan, delly_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.delly.Valle-Inclan_2020.txt")
delly_count_novel_Arora, delly_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.delly.benchmark.result.txt")

cutesv_count_detected_Arora, cutesv_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.cutesv.Arora_2019.txt")
cutesv_count_detected_Valle_Inclan, cutesv_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.cutesv.Valle-Inclan_2020.txt")
cutesv_count_novel_Arora, cutesv_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.cutesv.benchmark.result.txt")

camphor_count_detected_Arora, camphor_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.camphor.Arora_2019.txt")
camphor_count_detected_Valle_Inclan, camphor_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.camphor.Valle-Inclan_2020.txt")
camphor_count_novel_Arora, camphor_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.camphor.benchmark.result.txt")

svim_count_detected_Arora, svim_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.svim.Arora_2019.txt")
svim_count_detected_Valle_Inclan, svim_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.svim.Valle-Inclan_2020.txt")
svim_count_novel_Arora, svim_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.svim.benchmark.result.txt")

savana_strict_count_detected_Arora, savana_strict_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.savana_strict.Arora_2019.txt")
savana_strict_count_detected_Valle_Inclan, savana_strict_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.savana_strict.Valle-Inclan_2020.txt")
savana_strict_count_novel_Arora, savana_strict_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.savana_strict.benchmark.result.txt")
savana_lenient_count_detected_Arora, savana_lenient_count_nondetected_Arora = summarize_benchmark_detection("../output/COLO829_T_Nanopore.savana_lenient.Arora_2019.txt")
savana_lenient_count_detected_Valle_Inclan, savana_lenient_count_nondetected_Valle_Inclan = summarize_benchmark_detection("../output/COLO829_T_Nanopore.savana_lenient.Valle-Inclan_2020.txt")
savana_lenient_count_novel_Arora, savana_lenient_count_novel_Valle_Inclan = novel_sv_count("../output/COLO829_T_Nanopore.savana_lenient.benchmark.result.txt")

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

print('\t'.join(["savana_strict", "Arora_2019", "Detected", str(savana_strict_count_detected_Arora)]), file = hout)
print('\t'.join(["savana_strict", "Arora_2019", "Not detected", str(savana_strict_count_nondetected_Arora)]), file = hout)
print('\t'.join(["savana_strict", "Arora_2019", "New", str(savana_strict_count_novel_Arora)]), file = hout)
print('\t'.join(["savana_strict", "Valle_Inclan_2020", "Detected", str(savana_strict_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["savana_strict", "Valle_Inclan_2020", "Not detected", str(savana_strict_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["savana_strict", "Valle_Inclan_2020", "New", str(savana_strict_count_novel_Valle_Inclan)]), file = hout)

print('\t'.join(["savana_lenient", "Arora_2019", "Detected", str(savana_lenient_count_detected_Arora)]), file = hout)
print('\t'.join(["savana_lenient", "Arora_2019", "Not detected", str(savana_lenient_count_nondetected_Arora)]), file = hout)
print('\t'.join(["savana_lenient", "Arora_2019", "New", str(savana_lenient_count_novel_Arora)]), file = hout)
print('\t'.join(["savana_lenient", "Valle_Inclan_2020", "Detected", str(savana_lenient_count_detected_Valle_Inclan)]), file = hout)
print('\t'.join(["savana_lenient", "Valle_Inclan_2020", "Not detected", str(savana_lenient_count_nondetected_Valle_Inclan)]), file = hout)
print('\t'.join(["savana_lenient", "Valle_Inclan_2020", "New", str(savana_lenient_count_novel_Valle_Inclan)]), file = hout)
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

print('\t'.join(["savana_strict", "Arora_2019", str(float(savana_strict_count_detected_Arora) / float(savana_strict_count_detected_Arora + savana_strict_count_novel_Arora)),
    str(float(savana_strict_count_detected_Arora) / float(savana_strict_count_detected_Arora + savana_strict_count_nondetected_Arora))]), file = hout)
print('\t'.join(["savana_strict", "Valle_Inclan_2020", str(float(savana_strict_count_detected_Valle_Inclan) / float(savana_strict_count_detected_Valle_Inclan + savana_strict_count_novel_Valle_Inclan)),
    str(float(savana_strict_count_detected_Valle_Inclan) / float(savana_strict_count_detected_Valle_Inclan + savana_strict_count_nondetected_Valle_Inclan))]), file = hout)

print('\t'.join(["savana_lenient", "Arora_2019", str(float(savana_lenient_count_detected_Arora) / float(savana_lenient_count_detected_Arora + savana_lenient_count_novel_Arora)),
    str(float(savana_lenient_count_detected_Arora) / float(savana_lenient_count_detected_Arora + savana_lenient_count_nondetected_Arora))]), file = hout)
print('\t'.join(["savana_lenient", "Valle_Inclan_2020", str(float(savana_lenient_count_detected_Valle_Inclan) / float(savana_lenient_count_detected_Valle_Inclan + savana_lenient_count_novel_Valle_Inclan)),
    str(float(savana_lenient_count_detected_Valle_Inclan) / float(savana_lenient_count_detected_Valle_Inclan + savana_lenient_count_nondetected_Valle_Inclan))]), file = hout)
hout.close()

