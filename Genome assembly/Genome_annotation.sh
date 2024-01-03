#!/bin/bash
#augustus
etraining --species=AS genes.train > train.out2
augustus --species=AS --gff3=on as_masked.fasta > ./as.augustus.gff3
#tophat+cufflinks
cat rna.list| while read  i 
tophat -p 60 -o ${i}.Tophat ${i}.R1.clean.fastq.gz ${i}.R2.clean.fastq.gz; samtools sort -@ 60 ${i}.Tophat/accepted_hits.bam -T Sor -o ${i}.Tophat/accepted_hits_sort.bam; cufflinks -p 60 -o ./${i}.cufflinks  ./${i}.Tophat./accepted_hits_sort.bam
cuffmerge ./Total.cufflinks.gtf.lst -p 4 --ref-sequence ./as_masked.fasta
#genewise
for i in *.fasta| do 
homolog_genewise --cpu 40 --coverage_ratio 0.4 --evalue 1e-9 ${i} as_masked.fasta
done 
