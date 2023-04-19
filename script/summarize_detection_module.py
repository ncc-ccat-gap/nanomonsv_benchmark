#! /usr/bin/env python

import csv

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

def summarize_benchmark_svtype_detection(benchmark_file):

    detected_info = {
       "BND": {"count_detected": 0, "count_nondetected": 0},
       "DEL": {"count_detected": 0, "count_nondetected": 0},
       "INS/DUP": {"count_detected": 0, "count_nondetected": 0},
       "INV": {"count_detected": 0, "count_nondetected": 0},
       "other": {"count_detected": 0, "count_nondetected": 0},
    }
    with open(benchmark_file, 'r') as hin:
        for line in hin:
            F = line.rstrip('\n').split('\t')
            chr1 = F[0]
            chr2 = F[3]
            strand = F[2] + F[5]
            detected = F[8]

            if chr1 != chr2:
                sv_type = "BND"
            elif strand == "+-":
                sv_type = "DEL"
            elif strand == "-+":
                sv_type = "INS/DUP"
            elif strand in ["++", "--"]:
                sv_type = "INV"
            else:
                raise Exception("Unexcepted SV_Type: %s" % (strand))

            if F[8] == "True":
                detected_info[sv_type]["count_detected"] += 1
            if F[8] == "False":
                detected_info[sv_type]["count_nondetected"] += 1

    return detected_info


def novel_sv_svtype_count(sv_file):

    novel_info_arora = {"BND": 0, "DEL": 0, "INS/DUP": 0, "INV": 0, "other": 0}
    novel_info_valle_inclan = {"BND": 0, "DEL": 0, "INS/DUP": 0, "INV": 0, "other": 0}

    with open(sv_file, 'r') as hin:
        for F in csv.DictReader(hin, delimiter = '\t'):
            if "SV_Type" in F:
                if F["SV_Type"] == "BND":
                    sv_type = "BND"
                elif F["SV_Type"] == "DEL":
                    sv_type = "DEL"
                elif F["SV_Type"] in ["INS", "DUP"]:
                    sv_type = "INS/DUP"
                elif F["SV_Type"] == "INV":
                    sv_type = "INV"
                elif F["SV_Type"] in ["CHR", "TRA"]:
                    sv_type = "other"
                else:
                    raise Exception("Unexcepted SV_Type: %s" % (F["SV_Type"]))
            else:
                chr1 = F["Chr_1"]
                chr2 = F["Chr_2"]
                strand = F["Dir_1"] + F["Dir_2"]
                if chr1 != chr2:
                    sv_type = "BND"
                elif strand == "+-":
                    sv_type = "DEL"
                elif strand == "-+":
                    sv_type = "INS/DUP"
                else:
                    sv_type = "INV"

            if F["Is_Arora"] == "NA":
                novel_info_arora[sv_type] +=1
            if F["Is_Valle_Inclan"] == "NA":
                novel_info_valle_inclan[sv_type] +=1

    return (novel_info_arora, novel_info_valle_inclan)

