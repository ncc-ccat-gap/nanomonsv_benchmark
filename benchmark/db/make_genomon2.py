#! /usr/bin/env python

import sys

input_file = sys.argv[1]
sind = 1
with open(input_file, 'r') as hin:
    for line in hin:
        if line.startswith("#"): continue
        F = line.rstrip('\n').split('\t')
        svkey = "Arora_" + str(sind) 

        schr1, spos1, sdir1, schr2, spos2, sdir2 = F[0], F[2], F[8], F[3], F[5], F[9]
        if schr1 > schr2 or (schr1 == schr2 and int(spos1) > int(spos2)):
            schr1, schr2 = schr2, schr1
            spos1, spos2 = spos2, spos1
            sdir1, sdir2 = sdir2, sdir1

        if schr1 == schr2 and abs(int(spos1) - int(spos2)) < 100: continue

        print('\t'.join([schr1, spos1, sdir1, schr2, spos2, sdir2, svkey, F[10]]))
        sind = sind + 1

# make_genomon1.py
# chrX    31178825        31178826        chrX    31198093        31198094        DEL     NA      +       -       [Svaba_SR=52,Svaba_PE=54],[Manta_PE=46,Manta_SR=47],[Lumpy_PE=29,Lumpy_SR=31]   lumpy,manta,svaba       COLO-829--COLO-829BL    known=;COSMIC;DisruptL=DMD;DisruptR=DMD;ClosestL=;ClosestR=     31283007        31283007        33,31178825,31198083    0,0,0


