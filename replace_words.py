#!/usr/bin/env python

import sys

def read_table(table_file):
    table = {}
    with open(table_file, 'r') as f:
        for line in f:
            key, value = line.strip().split('\t')
            table[key] = value
    return table

def replace_words(input_file, output_file, table):
    with open(input_file, 'r') as fin, open(output_file, 'w') as fout:
        for line in fin:
            words = line.strip().split('\t')
            modified_words = [table.get(word, word) for word in words]
            fout.write('\t'.join(modified_words) + '\n')

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python script.py input_file table_file output_file")
        sys.exit(1)

    input_file = sys.argv[1]
    table_file = sys.argv[2]
    output_file = sys.argv[3]

    table = read_table(table_file)
    replace_words(input_file, output_file, table)
    print("Words replaced successfully!")

