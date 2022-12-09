#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --partition=cpu
#SBATCH --time=0:30:00
#SBATCH --account=d2021-135-users
#SBATCH --mem-per-cpu=2000MB
#SBATCH --job-name=mos2
#SBATCH --reservation=maxcpu

# load yambo and dependencies
module purge
module use /ceph/hpc/data/d2021-135-users/modules
module load YAMBO/5.1.1-FOSS-2022a
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

# run job
srun --mpi=pmix -n ${SLURM_NTASKS} yambo -F gw.in -J GW_dbs -C GW_reports
