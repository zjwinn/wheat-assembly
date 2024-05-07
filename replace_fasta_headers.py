#!/usr/bin/env python

import sys

# Check if the correct number of arguments is provided
if len(sys.argv) != 4:
    print("Usage: python script.py input.fasta input_table.txt output.fasta")
    sys.exit(1)

# Parse arguments
input_fasta = sys.argv[1]
input_table = sys.argv[2]
output_fasta = sys.argv[3]

# Read the table and create a dictionary mapping old headers to new headers
header_map = {}
with open(input_table, 'r') as f:
    for line in f:
        old_header, new_header = line.strip().split('\t')
        header_map[old_header] = new_header

# Replace headers in the fasta file
with open(input_fasta, 'r') as f_in, open(output_fasta, 'w') as f_out:
    for line in f_in:
        if line.startswith('>'):
            header = line.strip()[1:]
            new_header = header_map.get(header, header)
            f_out.write('>' + new_header + '\n')
        else:
            f_out.write(line)

