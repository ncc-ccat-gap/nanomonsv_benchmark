#! /usr/bin/env python

import sys, csv

vcf_file = sys.argv[1]

with open(vcf_file, 'r') as hin:
    for line in hin:
        if line.startswith('#'): continue
        F = line.rstrip('\n').split('\t')

        tdir = '+' if F[4].startswith(F[3]) else '-'

        # if F[2].endswith("_2"): continue

        print("%s\t%s\t%s\t%s\t.\t%s\t%s" % ("chr" + F[0], str(int(F[1]) - 1), F[1], F[2], tdir, F[7]))
 
