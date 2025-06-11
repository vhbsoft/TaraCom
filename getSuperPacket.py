# =========================================
# Script Name: getSuperPacket.py
#
# Summary:
#     Aggregates simulation results into superpackets based on timing or structure.
#     Intermediate step before loss rate calculation.
#
# Input File: pcap or intermediate output
# Output File: superpacket_output
# Invoked by: simu_traffic_shaper.sh
# Input Files: compression_link_output
# Output Files: superpacket_output
# =========================================

import sys

# Get the arguments from the command line
args = sys.argv
n_i = int(args[1])
lamb = int(args[2]) 
out = 0

with open('compression_link_output', 'r') as file:
    lines = file.readlines()
    neg = 0
    count = 10
    for i, line in enumerate(lines[n_i:]):    
        if i % lamb == 0:
            out = 1
        
        val = line.split('\t')[1][:-1]

        if val == '-1':
            out = -1

        if i % lamb == lamb - 1:
            if count > 0:
                count-=1

            with open('superpacket_output', 'a') as outputfile:
                outputfile.write("{}\t{}\n".format(i // lamb, out))