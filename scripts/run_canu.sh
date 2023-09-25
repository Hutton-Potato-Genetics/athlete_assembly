#!/bin/bash

source activate vikrant_assembly

canu -nanopore reads.fastq.gz \
genomeSize=700m \
gridOptions="--partition=long" \
cnsMemory=10 -p canu \
-d canu