#!/bin/bash
#SBATCH --job-name=USERjob
#SBATCH --nodes 1
#SBATCH --exclusive
#SBATCH --time=00:20:00
#SBATCH --partition=cpu
#SBATCH --reservation=maxcpu
#SBATCH --ntasks-per-socket=2
#SBATCH --ntasks-per-node=...
#SBATCH --hint=nomultithread
#SBATCH --cpus-per-task=...
#SBATCH --output=sysout.out
#SBATCH --error=syserr.err
# # SBATCH --mail-user=YOUR_EMAIL - if you want

module purge
module load QuantumESPRESSO/7.1-foss-2022a

export EXDIR=${PWD}/..
export INDIR=${EXDIR}/inputs
export ESPRESSO_PSEUDO=${EXDIR}/../pseudo

mpiopt="-mca pml ucx -mca btl ^uct,tcp,openib,vader --map-by socket:PE=4 --rank-by core --report-bindings "

for nthr in ....
do
export OMP_NUM_THREADS="$nthr"
mpirun $mpiopt -np ... pw.x -npool ... -i ${INDIR}/pw.CuO.scf.in > pw_run16x${nthr}.out
done

