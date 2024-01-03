#!/bin/bash
##filter
vcftools --vcf all.snp.vcf --maf 0.05 --max-missing 0.8 --min-alleles 2 --max-alleles 2 --recode --out vcftools_maf0.05_missing0.8_allele2
##LD filter
plink --vcf vcftools_maf0.05_missing0.8_allele2.recode.vcf --indep-pairwise 50 10 0.2  --out as.ld --allow-extra-chr --set-missing-var-ids @:#
plink --vcf vcftools_maf0.05_missing0.8_allele2.recode.vcf --extract as.ld.prune.in --out  all.LDfiltered --recode vcf-iid  --keep-allele-order --allow-extra-chr --set-missing-var-ids @:#

##pca
plink --vcf all.LDfiltered.vcf  --pca 98 -out PCA_out --allow-extra-chr --set-missing -var-ids @:#

##ML tree
tassel-5-standalone/run_pipeline.pl -SortGenotypeFilePlugin -inputFile all.LDfiltered.vcf -outputFile sorted.vcf -fileType VCF
tassel-5-standalone/run_pipeline.pl -importGuess sorted.vcf -ExportPlugin -saveAs sequences.phy -format Phylip_Inter
iqtree -s sequences.phy -m MFP -bb 1000 --bnni -cmax 15 -nt AUTO

##sturcture
plink --vcf vcftools_maf0.05_missing0.8_allele2.recode.vcf --indep-pairwise 50 10 0.2 --out as.ld --allow-extra-chr --make-bed
plink --bfile as.ld -extract as.ld.prune.in --out prunData --recode 12 --allow-extra-chr
for ((i=1;i<=10;i++));do admixture --cv AS.bed $K | tee log${K}.out; done