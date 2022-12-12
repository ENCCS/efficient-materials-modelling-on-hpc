#!/bin/bash
#SBATCH --job-name=USERjob
#SBATCH --nodes 1
#SBATCH --time=00:10:00
#SBATCH --partition=gpu
#SBATCH --reservation=maxgpu
#SBATCH --ntasks-per-node=4
#SBATCH --ntasks-per-socket=2
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:4
#SBATCH --hint=nomultithread
#SBATCH --output=sysout.out
#SBATCH --error=syserr.err
# # SBATCH --mail-user=YOUR_EMAIL - if you want

export WORK=/ceph/hpc/data/d2021-135-users
module purge
module use ${WORK}/modules
echo $WORK
module load QuantumESPRESSO/DEV-NVHPC-21.2

export EXDIR=${PWD}/..
export INDIR=${EXDIR}/inputs
export ESPRESSO_PSEUDO=${EXDIR}/../pseudo
export OMP_NUM_THREADS=1

mpiopt="-mca pml ucx -mca btl ^uct,tcp,openib,vader  --map-by socket:PE=32 --rank-by core --report-bindings "

mpirun $mpiopt -np 4 pw.x -i ${INDIR}/pw.CnSnI3.in > pw.CnSnI3.gpu.out
