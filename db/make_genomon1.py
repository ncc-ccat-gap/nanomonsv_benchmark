#! /usr/bin/env python

import sys, re

input_file = sys.argv[1]

svkey2pos1 = {}
svkey2pos2 = {}
svkey2info = {}

with open(input_file, 'r') as hin:
    for line in hin:
        F = line.rstrip('\n').split('\t')
        if F[3].endswith('_1'):
            svkey = re.sub(r'_1$', '', F[3])
            svkey2pos1[svkey] = (F[0], F[2], F[5])
            svkey2info[svkey] = F[6]
        else:
            svkey = re.sub(r'_2$', '', F[3])
            svkey2pos2[svkey] = (F[0], F[2], F[5]) 

sind = 1
for svkey in sorted(svkey2pos1):
    is_ins = False
    schr1, spos1, sdir1 = svkey2pos1[svkey]
    if svkey in svkey2pos2:
        schr2, spos2, sdir2 = svkey2pos2[svkey]
    else:
        spos2 = spos1
        spos1 = str(int(spos1) - 1)
        sdir1, sdir2 = '+', '-'
        is_ins = True

    svkey2 = "Valle-Inclan_" + str(sind)    
    sinfo = svkey2info[svkey]

    if schr1 > schr2 or (schr1 == schr2 and int(spos1) > int(spos2)):
        schr1, schr2 = schr2, schr1
        spos1, spos2 = spos2, spos1
        sdir1, sdir2 = sdir2, sdir1

    if not is_ins and schr1 == schr2 and abs(int(spos1) - int(spos2)) < 100: continue
    
    print('\t'.join([schr1, spos1, sdir1, schr2, spos2, sdir2, svkey2, sinfo]))
    sind = sind + 1

