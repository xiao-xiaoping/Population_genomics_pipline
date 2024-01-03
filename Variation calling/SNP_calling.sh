#!/bin/bash
#call respectively to generate gvcf file
for i in sample.list
gatk --java-options "-Xmx20G HaplotypeCaller -I ${i}.sorted.rmdup.bam -O ${i}.g.vcf -R Ref/sequences.fa  -stand-call-conf 30 --sample-ploidy 2 --indel-size-to-eliminate-in-ref-model 50 --emit-ref-confidence GVCF
#combine gvcfs
gatk --java-options "-Xmx80G CombineGVCFs -R sequences.fa -V gvcfs.list -O combined.g.vcf
#genotyping
gatk --java-options "-Xmx20G  GenotypeGVCFs -R sequences.fa -V combined.g.vcf -O combined.raw.vcf
#dividing_snp
gatk --java-options "-Xmx20G SelectVariants -R sequences.fa -V first_filtered.merged.raw.vcf -O snp/raw.snp.vcf --select-type SNP
#hard_filter
gatk --java-options  VariantFiltration -R as.fa -V snp/raw.snp.vcf -O snp/filtered.snp.vcf --filter-expression "QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name "SNP_filter" --cluster-window-size 5 --cluster-size 2
