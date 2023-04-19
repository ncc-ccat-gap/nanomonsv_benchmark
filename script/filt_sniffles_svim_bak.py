#! /usr/bin/env python

import sys, csv

input_file = sys.argv[1]

print('\t'.join(["Chr_1", "Pos_1", "Dir_1", "Chr_2", "Pos_2", "Dir_2", "Inserted_Seq", 
    "Checked_Read_Num_Tumor", "Supporting_Read_Num_Tumor", "Checked_Read_Num_Control", "Supporting_Read_Num_Control", "SV_Type"]))

keys = {}
with open(input_file, 'r') as hin:
    for F in csv.reader(hin, delimiter = '\t'):
        if F[0] == "Chr_1": continue
        insert_seq = F[6] if F[6] != "---" else ''
        sv_size = int(F[4]) - int(F[1]) + len(insert_seq) - 1
        if sv_size <= 100: continue

        # import pdb; pdb.set_trace()
        tkey = (F[0], F[1], F[2], F[3], F[4], F[5])
        key_exist = False
        for key in keys:
            if tkey[0] == key[0] and tkey[2] == key[2] and tkey[3] == key[3] and tkey[5] == key[5]:
                if abs(int(tkey[1]) - int(key[1])) < 50 and abs(int(tkey[4]) - int(key[4])) < 50:
                    key_exist = True

        keys[tkey] = 1
        if key_exist == True: continue
 
        print('\t'.join(F))


