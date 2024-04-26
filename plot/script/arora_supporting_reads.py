#! /usr/bin/env python

import sys, re, statistics

input_file = sys.argv[1]

print('\t'.join(["SVkey", "Mean_SR", "Mean_PE", "Is_detected"]))
with open(input_file, 'r') as hin:
    for line in hin:
        F = line.rstrip('\n').split('\t')
        key = ','.join(F[:6])
        SR_count, PE_count = [], [] 
        for match in re.finditer(r'\w+_(\w\w)=(\d+)', F[7]):
            if match.group(1) == "SR": 
                SR_count.append(int(match.group(2)))
            else:
                PE_count.append(int(match.group(2)))

        mean_SR_count = statistics.mean(SR_count) if len(SR_count) > 0 else 0.0
        mean_PE_count = statistics.mean(PE_count) if len(PE_count) > 0 else 0.0
        print("%s\t%f\t%f\t%s" % (key, mean_SR_count, mean_PE_count, F[8]))



