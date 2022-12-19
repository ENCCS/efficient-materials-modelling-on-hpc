#!/bin/bash
#SBATCH --job-name=eelsSi
#SBATCH -N 1
#SBATCH --ntasks=64
#SBATCH --time=00:30:00
#SBATCH --partition=cpu
#SBATCH --ntasks-per-node=64
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --reservation=maxcpu

module purge
module load QuantumESPRESSO/7.1-foss-2022a

export OMP_NUM_THREADS=1

mpirun -np 64 turbo_eels.x -nk 16 -i turbo_eels.Si.tddfpt.in > turbo_eels.Si.tddfpt.out

