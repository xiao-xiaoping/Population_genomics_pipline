#!/bin/bash
##flye assembly
flye -g 500m --out-dir as_flye --asm-coverage 70 --pacbio-raw as_subreads.fastq.gz --threads 8

##remove haplotigs and contig overlaps
#calculate read depth histogram and base-level read depth
minimap2 -t 80 -x map-pb assembly.fa as_subreads.fastq.gz | gzip -c - > pb.gz
purge_dups/bin/pbcstat pb.gz
purge_dups/bin/calcuts PB.stat > cutoffs 2> calcults.log
#split an assembly and do a self-self mapping
purge_dups/bin/split_fa assembly.fa > asm.split
minimap2 -t 80 -xasm5 -DP asm.split asm.split | pigz -c > asm.split.self.gz
#get the purged sequences from draft assembly
purge_dups/bin/purge_dups -2 -T cutoffs -c PB.base.cov asm.split.self.gz > dups.bed 2> purge_dups.log
purge_dups/bin/get_seqs dups.bed assembly.fa

##polish
#racon_polish
input=01_Purge_dups/purged.fa
data=as_4.trimmedReads.fasta.gz
minimap2 -t 10 $input $data > round1.paf
racon -t 10 $data round1.paf $input > round1.fasta
minimap2 -t 10 round1.fasta $data > round2.paf
racon -t 10 $data round2.paf round1.fasta > round2.fasta
minimap2 -t 10 round2.fasta $data > round3.paf
racon -t 10 $data round3.paf round2.fasta > round3.fasta

#pilon_polish
bwa index -p index/draft draft.fa
bwa mem -t 20 index/round3 As-illumina_R1.fastq.gz As-illumina_R2.fastq.gz | samtools sort -@ 10 -O bam -o align.bam | samtools index -@ 10 align.bam
sambamba markdup -t 10 align.bam align_markdup.bam 
samtools view -@ 10 -q 30 align_markdup.bam > align_filter.bam
samtools index -@ 10 align_filter.bam
java -Xmx100G -jar pilon-1.23.jar --genome draft.fa --frags align_filer.bam \
    --fix snps,indels \
    --output pilon_polished --vcf &> pilon.log