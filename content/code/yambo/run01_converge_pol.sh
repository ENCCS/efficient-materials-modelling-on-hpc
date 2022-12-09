#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --partition=cpu
#SBATCH --time=0:30:00
#SBATCH --account=d2021-135-users
#SBATCH --mem-per-cpu=2000MB
#SBATCH --job-name=mos2

# load yambo and dependencies
module purge
module use /ceph/hpc/data/d2021-135-users/modules
module load YAMBO/5.1.1-FOSS-2022a
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

file0='i01-GW'

for POL_BANDS in 20 40 60 80; do

echo 'NGsBlkXp [Ry]   E_vale [eV]   E_cond [eV]' > summary_01_${POL_BANDS}bands.txt

for NGsBlkXp_Ry in 6 8 10 12; do

label=Xp_${POL_BANDS}_bands_${NGsBlkXp_Ry}_Ry
jdir=job_${label}
cdir=out_${label}
filein=i01-GW_${label}

sed "s/NGsBlkXp=.*/NGsBlkXp=${NGsBlkXp_Ry} Ry/;
      /% BndsRnXp/{n;s/.*/  1 |  ${POL_BANDS} |/}" $file0 > $filein

# run yambo
srun --mpi=pmix -n ${SLURM_NTASKS} yambo -F $filein -J $jdir -C $cdir

E_GW_v=`grep -v '#' ${cdir}/o-${jdir}.qp|head -n 1| awk '{print $3+$4}'`
E_GW_c=`grep -v '#' ${cdir}/o-${jdir}.qp|tail -n 1| awk '{print $3+$4}'`

GAP_GW=`echo $E_GW_c - $E_GW_v |bc`

echo ${NGsBlkXp_Ry} '        ' ${E_GW_v} '        ' ${E_GW_c} '        ' ${GAP_GW} >> summary_01_${POL_BANDS}bands.txt
done
done