#! /usr/bin/env bash

import sys
import pysam

input_file = sys.argv[1]
gene_file = sys.argv[2]
repeat_file = sys.argv[3]

# gene_margin = 10000
gene_margin = 0

gene_tb = pysam.TabixFile(gene_file)
repeat_tb = pysam.TabixFile(repeat_file)

with open(input_file, 'r') as hin:
    header = hin.readline().rstrip('\n')
    print(header + '\t' + '\t'.join(["Gene_1", "Gene_2", "Is_Simple_Repeat"]))
    for line in hin:
        F = line.rstrip('\n').split('\t')
        
        # check gene annotation for the side 1  
        tabixErrorFlag = 0
        try:
            records = gene_tb.fetch(F[0], int(F[1]) - 1 - gene_margin, int(F[1]) + gene_margin)
        except Exception as inst:
            print("%s: %s" % (type(inst), inst.args), file = sys.stderr)
            tabixErrorFlag = 1


        gene1 = [];
        if tabixErrorFlag == 0:
            for record_line in records:
                record = record_line.split('\t')
                gene1.append(record[3])

        if len(gene1) == 0: gene1.append("---")
        gene1 = ','.join(sorted(list(set(gene1))))

        # check gene annotation for the side 2
        tabixErrorFlag = 0
        try:
            records = gene_tb.fetch(F[3], int(F[4]) - 1 - gene_margin, int(F[4]) + gene_margin)
        except Exception as inst:
            print("%s: %s" % (type(inst), inst.args), file = sys.stderr)
            tabixErrorFlag = 1

        gene2 = [];
        if tabixErrorFlag == 0:
            for record_line in records:
                record = record_line.split('\t')
                gene2.append(record[3])

        if len(gene2) == 0: gene2.append("---")
        gene2 = ','.join(sorted(list(set(gene2))))


        # check simplerepeat annotation
        repeat = "None"
        if F[0] == F[3] and int(F[4]) - int(F[1]) < 100000:
            tabixErrorFlag = 0
            try:
                records = repeat_tb.fetch(F[0], int(F[1]) - 50, int(F[1]) + 50)
            except Exception as inst:
                print("%s: %s" % (type(inst), inst.args), file = sys.stderr)
                tabixErrorFlag = 1

            if tabixErrorFlag == 0:
                for record_line in records:
                    record = record_line.split('\t')
                    if int(F[1]) >= int(record[1]) - 50 and int(F[4]) <= int(record[2]) + 50:
                        repeat = record[0] + ':' + record[1] + '-' + record[2]

        print('\t'.join(F) + '\t' + '\t'.join([gene1, gene2, repeat]))


