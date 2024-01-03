#!/bin/bash
#SV calling for each sample
for i in *.sorted.rmdup.bam | do
delly call -g Ref/sequences.fa $i  -o  ${i}.bcf
done
#merge 
delly merge -o sites.bcf list.txt
#recalling
for i in *.sorted.rmdup.bam | do
delly call -g Ref/sequences.fa -v sites.bcf $i  -o  ${i}_R.bcf
done
bcftools merge -m id  -O b -o merged.bcf -l bcf.list
#filter
delly filter -f germline -p -m 50 -o germline.bcf merged.bcf 