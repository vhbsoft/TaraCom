# =========================================
# Script Name: countSpLossRate.py
#
# Summary:
#     This script analyzes the "superpacket_output" file and calculates
#     the percentage of packets with a second field of -1 (indicating loss).
#     It then appends this percentage value (formatted as 'xx.xx,') to a specified output file.
#
# Input File: superpacket_output
# Output File: <arg1> (e.g., result.txt)
#
# Usage:
#     python countSpLossRate.py result.txt 5
#         - result.txt is the file to append loss rate result
#         - 5 is an unused parameter (likely for bookkeeping)
#
# Called by: simu_traffic_shaper.sh
# =========================================

import sys

# Get the arguments from the command line
args = sys.argv
outputfilename = args[1]
lamb = args[2]

val = 0

with open('superpacket_output', 'r') as file:
    lines = file.readlines()
    neg = 0
    for line in lines:
        if line.split('\t')[1][:-1] == '-1':
            neg += 1
    
    # neg/nonneg
    val = (neg / len(lines)) * 100
    print("python script result: ", val)

with open(outputfilename, 'a') as file:
    file.write('{:.2f},'.format(val))