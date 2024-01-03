#!/bin/bash
for i in *.bam | do
bcftools mpileup -Ou -I -f as.fasta $i | bcftools call -c -Ov | vcfutils.pl vcf2fq -d 10 -D 100 | gzip > ${i}.fq.gz
psmc-0.6.5/utils/fq2psmcfa -q20 ${i}.fq.gz > ${i}.psmcfa
psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o ${i}.psmc ${i}.psmcfa
done