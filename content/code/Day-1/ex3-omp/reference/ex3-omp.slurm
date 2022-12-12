#!/bin/bash
#SBATCH --job-name=USERjob
#SBATCH --nodes 1
#SBATCH --exclusive
#SBATCH --time=00:20:00
#SBATCH --partition=cpu
#SBATCH --ntasks-per-socket=2
#SBATCH --ntasks-per-node=16
#SBATCH --hint=nomultithread
#SBATCH --cpus-per-task=4
#SBATCH --output=sysout.out
#SBATCH --error=syserr.err
# # SBATCH --mail-user=YOUR_EMAIL - if you want

module purge
module load QuantumESPRESSO/7.1-foss-2022a

export EXDIR=${PWD}/..
export INDIR=${EXDIR}/inputs
export ESPRESSO_PSEUDO=${EXDIR}/../pseudo

mpiopt="-mca pml ucx -mca btl ^uct,tcp,openib,vader --map-by socket:PE=4 --rank-by core --report-bindings "

for nthr in 1 2 4
do
export OMP_NUM_THREADS="$nthr"
mpirun $mpiopt -np 16 pw.x -npool 8 -i ${INDIR}/pw.CuO.scf.in > pw_run16x${nthr}.out
done

