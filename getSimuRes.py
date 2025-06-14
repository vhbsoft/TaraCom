# =========================================
# Script Name: getSimuRes.py
#
# Summary:
#     This script calculates the percentage of lines in compression_link_output
#     where the second field is -1 (indicating a failed packet).
#     It writes this loss percentage along with arguments p, n, and capacity to a results file.
#     It also saves a copy of compression_link_output with a unique name under ./output/.
#
# Input File: compression_link_output
# Output Files:
#     - <arg1>: summary result file, appended with p,n,capacity and loss
#     - ./output/<arg1>_output_<p>_<n>_<capacity>: full copy of original output
#
# Usage:
#     python getSimuRes.py result.txt 40 25 3
#
# Called by: simu_comp_link_capacity.sh
# =========================================

import sys

# Get the arguments from the command line
args = sys.argv

val = 0

with open('compression_link_output', 'r') as file:
    lines = file.readlines()
    neg = 0
    for line in lines:
        if line.split('\t')[1][:-1] == '-1':
            neg += 1
    
    # neg/nonneg
    val = (neg / len(lines)) * 100
    print("python script result: ", val)

with open('compression_link_output', 'r') as file:
    content = file.read()

# write it to the output file
with open(args[1], 'a') as file:
    file.write('{},'.format(','.join(args[2:5])))
    file.write('{}\n'.format(val))

with open('./output/'+args[1]+'_output_{}'.format('_'.join(args[2:])), 'w') as outputfile:
    outputfile.write(content)
