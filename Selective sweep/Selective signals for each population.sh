##Fst
vcftools --vcf filtered2.vcf --weir-fst-pop 1_population.txt --weir-fst-pop  2_population.txt  --out p_1_2_bin --fst-window-size 10000 --fst-window-step 2000
i=1_2
##PI
vcftools --vcf filtered2.vcf --keep 1_population.txt --window-pi 20000 --window-pi-step 5000 --out 1_population
vcftools --vcf filtered2.vcf --keep 2_population.txt --window-pi 20000 --window-pi-step 5000 --out 2_population
##Then take the top 5% regions of Fst and PI_ratio separately and merge them