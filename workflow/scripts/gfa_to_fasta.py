#!/usr/bin/env python

import sys

def gfa_to_fasta(gfa_file, fasta_file):
    try:
        with open(gfa_file, 'r') as gfa:
            with open(fasta_file, 'w') as fasta:
                for line in gfa:
                    if line.startswith('S\t'):  # S lines contain sequence information in GFA format
                        parts = line.strip().split('\t')
                        if len(parts) >= 3:
                            sequence_id = parts[1]
                            sequence = parts[2]
                            fasta.write(f'>{sequence_id}\n{sequence}\n')
        print(f'Conversion successful! Converted {gfa_file} to {fasta_file}.')
    except FileNotFoundError:
        print(f'Error: File {gfa_file} not found.')

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: python script.py input_gfa_file output_fasta_file')
        sys.exit(1)
    
    input_gfa_file = sys.argv[1]
    output_fasta_file = sys.argv[2]
    
    gfa_to_fasta(input_gfa_file, output_fasta_file)
