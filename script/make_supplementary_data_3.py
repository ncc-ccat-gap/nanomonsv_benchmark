#! /usr/bin/env python3

import sys, csv

input_file_1 = sys.argv[1]
input_file_2 = sys.argv[2]
input_file_3 = sys.argv[3]

def add_key2info(input_file, key2info, num):

    key2detected = {}
    with open(input_file, 'r') as hin:
        for F in csv.DictReader(hin, delimiter = '\t'):
            tchr1, tpos1, tdir1, tchr2, tpos2, tdir2 = \
                F["Chr_1"], F["Pos_1"], F["Dir_1"], F["Chr_2"], F["Pos_2"], F["Dir_2"]
            tpos1, tpos2 = int(tpos1), int(tpos2)

            is_detected = False
            for key in key2info:
                if key[0] == tchr1 and key[2] == tdir1 and key[3] == tchr2 and key[5] == tdir2 and \
                    abs(tpos1 - key[1]) < 20 and abs(tpos2 - key[4]) < 20:
                    key2info[key].append(F["Supporting_Read_Num_Tumor"])
                    is_detected = True
                    key2detected[key] = True
                    break

            if is_detected == False:
                is_arora = "TRUE" if F["Is_Arora"] != "NA" else "FALSE"
                is_valle_inclan = "TRUE" if F["Is_Valle_Inclan"] != "NA" else "FALSE"
                tkey = (tchr1, tpos1, tdir1, tchr2, tpos2, tdir2, F["Inserted_Seq"], is_arora, is_valle_inclan)
                key2info[tkey] = ["Not detected"] * num
                key2info[tkey].append(F["Supporting_Read_Num_Tumor"])
                key2detected[tkey] = True

    for key in key2info:
        if key not in key2detected:
            key2info[key].append("Not detected")

key2info = {}
add_key2info(input_file_1, key2info, 0)
add_key2info(input_file_2, key2info, 1)
add_key2info(input_file_3, key2info, 2)

print("Chr_1\tPos_1\tDir_1\tChr_2\tPos_2\tDir_2\tInserted_Seq\tIs_Arora_et_al_2019\tIs_Valle-Inclan_et_al_2020\t" + \
    "ONT_our_data_Supporting_Read_Num\tONT_PRJEB27698_Supporting_Read_Num\tPBS_PRJEB27698_Supporting_Read_Num")
for key in key2info:
    tkey = '\t'.join([str(x) for x in key])
    tinfo = '\t'.join(key2info[key])
    print(f"{tkey}\t{tinfo}")

