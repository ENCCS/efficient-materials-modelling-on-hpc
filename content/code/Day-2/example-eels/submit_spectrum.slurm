#!/bin/bash
#SBATCH --job-name=specSi
#SBATCH -N 1
#SBATCH --ntasks=1
#SBATCH --time=00:30:00
#SBATCH --partition=cpu
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --reservation=maxcpu

module purge
module load QuantumESPRESSO/7.1-foss-2022a

export OMP_NUM_THREADS=1

mpirun -np 1 turbo_spectrum.x -i turbo_spectrum.Si.pp.in > turbo_spectrum.Si.pp.out


