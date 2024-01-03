#!/bin/bash
#Repeatmodeler
BuildDatabase -name AS -engine ncbi pilon_polished2.fa
RepeatModeler -engine ncbi -database AS -pa 5
#RepeatMasker
RepeatMasker -e ncbi -s -gff -x -nolow -pa 10 -lib RepeatMasker.lib pilon_polished2.fasta
