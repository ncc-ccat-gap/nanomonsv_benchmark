#! /usr/bin/env python

import sys, csv

def basic_filter(row):

    filter_flag = False
    if row["Chr_1"].endswith("decoy"): filter_flag = True
    if row["Chr_2"].endswith("decoy"): filter_flag = True
    if row["Supporting_Read_Num_Control"] != "0": filter_flag = True

    if row["Chr_1"] == row["Chr_2"] and row["Dir_1"] == '+' and row["Dir_2"] == '-':
        sv_size = int(row["Pos_2"]) - int(row["Pos_1"]) + len(row["Inserted_Seq"]) - 1
        if sv_size < 100: filter_flag = True

        if row["Is_Simple_Repeat"] != "None" and row["Insert_Type"] in ["None", "---"]: filter_flag = True
        # insert_type = row["Insert_Type"]
        # if insert_type not in ["None", "---"] and row["Is_Simple_Repeat"] != "None": filter_flag = True

    return filter_flag

 
input_file = sys.argv[1]
review_file = sys.argv[2]
cg_file = sys.argv[3]



svkey2review = {}
with open(review_file, 'r') as hin:
    for row in csv.reader(hin, delimiter = '\t'):
        svkey = '\t'.join(row[:6])
        svkey2review[svkey] = row[7]


gene2cg = {}
with open(cg_file, 'r') as hin:
    for row in csv.DictReader(hin, delimiter = ','):
        gene_symbol = row['Gene Symbol']
        mut_type = row['Mutation Types']
        gene2cg[gene_symbol] = mut_type


svkey2read_num = {}
with open(input_file, 'r') as hin:
    for row in csv.DictReader(hin, delimiter = '\t'):
        if basic_filter(row): continue
        svkey = '\t'.join([row[x] for x in ["Chr_1", "Pos_1", "Dir_1", "Chr_2", "Pos_2", "Dir_2"]])
        if row["Inserted_Seq"] == "---": row["Inserted_Seq"] = ""
        svkey2read_num[svkey] = (int(row["Supporting_Read_Num_Control"]), len(row["Inserted_Seq"]))



# print('\t'.join(header) + '\t' + "Manual_Review_YS" + '\t' + "Cancer_Gene_1" + '\t' + "Cancer_Gene_2")
header_print = False
svkey2writtern = {}
with open(input_file, 'r') as hin:
    for row in csv.DictReader(hin, delimiter = '\t'):

        if header_print == False:
            print('\t'.join(row) + '\t' + "Manual_Review_YS" + '\t' + "Cancer_Gene_1" + '\t' + "Cancer_Gene_2")
            header_print = True

        if basic_filter(row): continue
        inseq_len_self = 0 if row["Inserted_Seq"] == "---" else len(row["Inserted_Seq"])
        svkey_line_self = '\t'.join([row[x] for x in ["Chr_1", "Pos_1", "Dir_1", "Chr_2", "Pos_2", "Dir_2"]])
        if svkey_line_self in svkey2writtern: continue
       
 
        match_flag1 = False
        for svkey_line in svkey2read_num:
            if svkey_line == svkey_line_self: continue
            svkey = svkey_line.split('\t')
            if row["Chr_1"] == svkey[0] and row["Chr_2"] == svkey[3]:
                if row["Dir_1"] == svkey[2] and row["Dir_2"] == svkey[5]:
                    if abs(int(row["Pos_1"]) - int(svkey[1])) <= 20 and abs(int(row["Pos_2"]) - int(svkey[4])) <= 20:

                        if int(row["Supporting_Read_Num_Control"]) < svkey2read_num[svkey_line][0]: 
                            match_flag1 = True
                        elif int(row["Supporting_Read_Num_Control"]) == svkey2read_num[svkey_line][0]:
                            if inseq_len_self > svkey2read_num[svkey_line][1]:
                                match_flag1 = True
                            elif inseq_len_self == svkey2read_num[svkey_line][1]:
                                if svkey_line < svkey_line_self:
                                    match_flag1 = True 


        match_flag2 = False
        """
        if match_flag1 == False:
            for svkey_line in svkey2read_num:
                if svkey_line == svkey_line_self: continue
                svkey = svkey_line.split('\t')
                if svkey2read_num[svkey_line][1] < 100: continue
                if row["Chr_1"] == svkey[0] and abs(int(row["Pos_1"]) - int(svkey[1])) <= 20: match_flag2 = True
                if row["Chr_2"] == svkey[3] and abs(int(row["Pos_2"]) - int(svkey[4])) <= 20: match_flag2 = True
        """

        review = "NA" if svkey_line_self not in svkey2review else svkey2review[svkey_line_self]

        cg_1 = []
        for g1 in row["Gene_1"].split(','):
            if g1 in gene2cg: cg_1.append(gene2cg[g1])
        if len(cg_1) == 0: cg_1.append("NA")

        cg_2 = []
        for g2 in row["Gene_2"].split(','):
            if g2 in gene2cg: cg_2.append(gene2cg[g2])
        if len(cg_2) == 0: cg_2.append("NA")
 

        if match_flag1 == False and match_flag2 == False:       
            print('\t'.join(row.values()) + '\t' + review + '\t' + ';'.join(cg_1) + '\t' + ';'.join(cg_2))
            svkey2writtern[svkey_line_self] = 1

"""
Chr_1   Pos_1   Dir_1   Chr_2   Pos_2   Dir_2   Inserted_Seq    Checked_Read_Num_Tumor  Supporting_Read_Num_Tumor       Checked_Read_Num_Control        Supporting_Read_Num_Control     Gene_1  Gene_2  Is_Simple_Repeat_1      Is_Simple_Repeat_2      Insert_Type     Is_Inversion    L1_Raito        Alu_Ratio       SV_Ratio        RMSK_Info       Alignment_Info  Inserted_Pos    Is_PolyA_T      Target_Site_Duplication L1_Source_Info  PSD_Gene        PSD_Overlap_Ratio       PDS_Exon_Num    SV_Class        Is_shortSV      ShortSV_key     Is_Genomon      Is_Manta        Is_SvABA        Is_GRIDSS       Is_TraFiC
chr1    100694465       +       chr1    100694466       -       TTGTAATTTCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTGGATGTATATGTCTTTATTTCTCTTAAGTAAACACCTAGGGTAGGGTTATAGGTCTATGGTAAACATATGTTTAACTTTTTTTTTTTTTTTCAAATTAAAAAAATAAATTCCTTAAT  30
      15      27      0       ---     ---     None    None    Partnered_L1    ---     0.641   0.0     0.0     11,49,+,(T)n,Simple_repeat,1,39;56,130,-,L1M5,LINE/L1,5670,5593 47,140,+,60,chr2,43660356,43660450      ---     polyT   TTGTAATTTCTTT   chr2,43660471,43666500,-,L1PA2  ---     ---     ---     Insertion       Partially detected      chr1,100694538,+,chr2,43660268,-,---,BND        ---     chr1,100694538,+,chr2,43660268,-,       ---     chr1,100694478,+,chr2,43660356,-,TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT     ---
"""         
    
