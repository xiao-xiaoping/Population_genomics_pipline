#!/bin/bash
for line in `cat chr_grid`
do
  chr=${line%%,}
  grid=${line##,}
  SweeD-P -name pop1.chr${chr}.10kb 
        -input pop1.chr${chr}.vcf 
        -grid ${grid} 
        -minsnps 200 
        -missing 0.1
done
