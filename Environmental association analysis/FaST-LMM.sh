#!/bin/bash
for i in *.phe| do
fastlmmc -file test -pheno {i}.phe -fileSim test -out fastlmm_{i}.out.txt -missingPhenotype NA -maxChromosomeValue 1000000 -maxThreads 5
done