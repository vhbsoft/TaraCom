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