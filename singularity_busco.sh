#!/bin/bash

#SBATCH --time=45:00
#SBATCH --mem=48G #default is 1 core with 2.8GB of memory
#SBATCH -n 12
##SBATCH --account=epscor-condo

#goal of script: 
#this script will take a busco.sif image and a draft genome/set of contigs, and run busco via singularity exec in a writable sandbox. then the output folder will be copied back from the sandbox to the working directory and the sandbox is deleted.
#the goal here is to have a ready to go script for reproducibly running busco wherever you are.

#specify genome
GENOME=$1

#build singularity sandbox from busco.sif image
singularity build -s busco_sandbox $LOCAL_DIR_OF_IMAGES/busco.sif

#run busco in sandbox
singularity exec -w --no-home -B $PWD:/mnt -w busco_sandbox busco -i mnt/$GENOME --out output --mode genome -l stramenopiles_odb10 -f -c 12

#cp output from sandbox to working directory
cp mydir/output .

#remove sandbox
rm -rf mydir
