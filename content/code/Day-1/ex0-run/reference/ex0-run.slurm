#!/bin/bash
#SBATCH --job-name=USERjob
#SBATCH --nodes 1
#SBATCH --time=00:00:30
#SBATCH --partition=cpu
#SBATCH --ntasks-per-socket=1
#SBATCH --ntasks-per-node=1
#SBATCH --hint=nomultithread
#SBATCH --cpus-per-task=1
#SBATCH --output=sysout.out
#SBATCH --error=syserr.err

export EXDIR=${PWD}/..

module purge
module load QuantumESPRESSO/7.1-foss-2022a

#input file directory
export INDIR=${EXDIR}/inputs
#pseudo file directory
export ESPRESSO_PSEUDO=${EXDIR}/../pseudo

# number of threads (serial)
export OMP_NUM_THREADS=1
# execute PW
mpirun -np 1 pw.x -in ${INDIR}/atom-pbe.in > atom-pbe.out
