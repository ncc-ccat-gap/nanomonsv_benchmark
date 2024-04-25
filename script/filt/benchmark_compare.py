#! /usr/bin/env python

import sys, csv

arora = []
valle_inclan = []


input_file = sys.argv[1]
arora_file = sys.argv[2]
valle_inclan_file = sys.argv[3]
output_file = sys.argv[4]
output_arora_nondetected = sys.argv[5]
output_valle_inclan_nondetected = sys.argv[6]

class Somatic_SV(object):
    
    def __init__(self, tchr1, tpos1, tdir1, tchr2, tpos2, tdir2, tname, tinfo):
        self.chr1 = tchr1
        self.pos1 = int(tpos1)
        self.dir1 = tdir1
        self.chr2 = tchr2
        self.pos2 = int(tpos2)
        self.dir2 = tdir2
        self.name = tname
        self.info = tinfo
        self.detected = False

    def print_line(self):
        return("%s\t%d\t%s\t%s\t%d\t%s\t%s\t%s" % (self.chr1, self.pos1, self.dir1, self.chr2, self.pos2, self.dir2, self.name, self.info))


with open(arora_file, 'r') as hin:
    for line in hin:
        F = line.rstrip('\n').split('\t')
        sv = Somatic_SV(F[0], F[1], F[2], F[3], F[4], F[5], F[6], F[7])
        arora.append(sv)

with open(valle_inclan_file, 'r') as hin:
    for line in hin:
        F = line.rstrip('\n').split('\t')
        sv = Somatic_SV(F[0], F[1], F[2], F[3], F[4], F[5], F[6], F[7])
        valle_inclan.append(sv)

hout = open(output_file, 'w')
with open(input_file, 'r') as hin:
    dreader = csv.DictReader(hin, delimiter = '\t')
    print('\t'.join(dreader.fieldnames + ["Is_Arora", "Is_Valle_Inclan"]), file = hout)

    for F in dreader:
        is_arora = "NA"
        for tsv in arora:
            if "SV_Type" in F and F["SV_Type"] == "INS" and \
              F["Chr_1"] == tsv.chr1 and \
              (F["Dir_1"] == tsv.dir1 or F["Dir_1"] == "*") and \
              abs(int(F["Pos_1"]) - tsv.pos1) < 100:
                is_arora = tsv.name
                tsv.detected = True

            if is_arora == "NA" and F["Chr_1"] == tsv.chr1 and F["Chr_2"] == tsv.chr2 and \
              (F["Dir_1"] == tsv.dir1 or F["Dir_1"] == "*") and (F["Dir_2"] == tsv.dir2 or F["Dir_2"] == "*") and \
              abs(int(F["Pos_1"]) - tsv.pos1) < 100 and abs(int(F["Pos_2"]) - tsv.pos2) < 100:
                is_arora = tsv.name
                tsv.detected = True

        is_valle_inclan = "NA"
        for tsv in valle_inclan: 
            if "SV_Type" in F and F["SV_Type"] == "INS" and \
              F["Chr_1"] == tsv.chr1 and \
              (F["Dir_1"] == tsv.dir1 or F["Dir_1"] == "*") and \
              abs(int(F["Pos_1"]) - tsv.pos1) < 100:
                is_valle_inclan = tsv.name
                tsv.detected = True

            if is_valle_inclan == "NA" and F["Chr_1"] == tsv.chr1 and F["Chr_2"] == tsv.chr2 and \
              (F["Dir_1"] == tsv.dir1 or F["Dir_1"] == "*") and (F["Dir_2"] == tsv.dir2 or F["Dir_2"] == "*") and \
              abs(int(F["Pos_1"]) - tsv.pos1) < 100 and abs(int(F["Pos_2"]) - tsv.pos2) < 100:
                is_valle_inclan = tsv.name
                tsv.detected = True

        print('\t'.join(list(F.values()) + [is_arora, is_valle_inclan]), file = hout)
hout.close()

hout = open(output_arora_nondetected, 'w')
for tsv in arora:
    # if tsv.detected == False:
    # if tsv.chr1 == tsv.chr2 and abs(tsv.pos1 - tsv.pos2) <= 100: continue
    print(tsv.print_line() + '\t' + str(tsv.detected), file = hout)

hout = open(output_valle_inclan_nondetected, 'w')
for tsv in valle_inclan:
    # if tsv.detected == False:
    # if tsv.chr1 == tsv.chr2 and abs(tsv.pos1 - tsv.pos2) <= 100: continue 
    print(tsv.print_line() + '\t' + str(tsv.detected), file = hout)


