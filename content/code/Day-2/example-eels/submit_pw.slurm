#!/bin/bash
#SBATCH --job-name=pwSi
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

mpirun -np 64 pw.x -nk 16 -i pw.Si.scf.in > pw.Si.scf.out

