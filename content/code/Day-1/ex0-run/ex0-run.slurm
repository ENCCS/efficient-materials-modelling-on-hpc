#!/bin/bash
#SBATCH --job-name=USERjob
#SBATCH --nodes 1
#SBATCH --time=00:00:30
#SBATCH --partition=cpu
#SBATCH --reservation=maxcpu
#SBATCH --ntasks-per-socket=...
#SBATCH --ntasks-per-node=...
#SBATCH --hint=nomultithread
#SBATCH --cpus-per-task=...
#SBATCH --output=sysout.out
#SBATCH --error=syserr.err

export EXDIR=${PWD}/..

module purge
module load QuantumESPRESSO/7.1-foss-2022a

export INDIR=${EXDIR}/inputs
export ESPRESSO_PSEUDO=${EXDIR}/../pseudo

# number of threads (serial)
export OMP_NUM_THREADS=...
# execute PW
mpirun ...
