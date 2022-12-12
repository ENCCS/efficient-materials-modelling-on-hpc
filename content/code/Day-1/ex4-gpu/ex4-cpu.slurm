#!/bin/bash
#SBATCH --job-name=USERjob
#SBATCH --nodes 1
#SBATCH --exclusive
#SBATCH --time=00:10:00
#SBATCH --partition=cpu
#SBATCH --reservation=maxcpu
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=8
#SBATCH --output=sysout.out
#SBATCH --error=syserr.err
# # SBATCH --mail-user=YOUR_EMAIL - if you want

# module purge
# module use ${WORK}/modules
# echo $WORK
# module load QuantumESPRESSO/DEV-NVHPC-21.2-FIXMAG
module purge
module load QuantumESPRESSO/7.1-foss-2022a

export EXDIR=${PWD}/..
export INDIR=${EXDIR}/inputs
export ESPRESSO_PSEUDO=${EXDIR}/../pseudo

export OMP_NUM_THREADS=4

mpiopt="-mca pml ucx -mca btl ^uct,tcp,openib,vader --map-by socket:PE=4 --rank-by socket --report-bindings "

mpirun $mpiopt -np 16 pw.x -i ${INDIR}/pw.CnSnI3.in > pw.CnSnI3.cpu.out

