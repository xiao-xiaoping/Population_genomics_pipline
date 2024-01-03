##!/bin/bash

##Genotype data
java -Xmx40g -jar /public/home/wangping/biosoft/beagle.05May22.33a.jar gt=filt.vcf nthreads=2 out=filt.beagle.vcf
##vcf2bed
vcftools --gzvcf filt.beagle.vcf.gz --plink --out out
plink --file out --allow-extra-chr --make-bed --out test
##gemma
gemma-0.98.1-linux-static -bfile test -gk 2 -o kinship
for i in {1..3}
do
echo $i
gemma-0.98.5-linux-static-AMD64 -bfile test -k output/kin.sXX.txt -lmm 4 -n ${i} -o out${i}
done
