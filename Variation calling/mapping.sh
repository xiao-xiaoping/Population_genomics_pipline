#!/bin/bash
#index
bwa index as.fa -p as
#mapping
for i in sample.list
bwa mem Ref/sequences.fa ${i}_1.fq ${i}_2.fq -t 2 -M -R "@RG\tID:S01\tLB:S01\tPL:ILLUMINA\tSM:S01" > Mapping/01_sam_files/${i}.sam
#sort_bam
for i in sample.list
gatk --java-options "-Xmx20G  SortSam --VALIDATION_STRINGENCY LENIENT --SORT_ORDER coordinate --INPUT Mapping/01_sam_files/${i}.sam --OUTPUT Mapping/02_sorted_bam_files/${i}.sorted.bam
#rmdup
for i in sample.list
gatk --java-options "-Xmx20G - MarkDuplicates -I Mapping/02_sorted_bam_files/${i}.sorted.bam -O Mapping/03_rmdup_bam_files/${i}.sorted.rmdup.bam -M /Mapping/03_rmdup_bam_files/${i}.rmdup.log --VALIDATION_STRINGENCY LENIENT --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 1000 --ASSUME_SORTED true --CREATE_INDEX true