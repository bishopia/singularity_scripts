#!/bin/bash

#SBATCH --time=45:00
#SBATCH --mem=48G #default is 1 core with 2.8GB of memory
#SBATCH -n 12
##SBATCH --account=epscor-condo

GENOME=trot_asm2.2.fa

#build singularity sandbox from busco.sif image
singularity build -s busco_sandbox busco.sif

#run busco in sandbox
singularity exec -w --no-home -B $PWD:/mnt -w busco_sandbox busco -i mnt/$GENOME --out output --mode genome -l stramenopiles_odb10 -f -c 12

#cp output from sandbox to working directory
cp mydir/output .

#remove sandbox
rm -rf mydir
