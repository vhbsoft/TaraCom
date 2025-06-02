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
