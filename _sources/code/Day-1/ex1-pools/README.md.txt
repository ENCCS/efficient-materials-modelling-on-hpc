EXERCISE 1 - Parallelization with pools
=================================================

Try to predict the best value of npool and check by performing a number of runs.

1. Open the batch file 'ex1-pools.slurm' and customize the user-related SLURM options like job-name and mail-user (not essential at all);  
Replace the dots with a list of proper values for npool, e.g:
       
        for ip in 1 2 3 4 5 6     -not the necessarily the right values here!
        do

2. Submit the job file:

        sbatch ./ex1-pools.slurm

3. Look for total WALL time at the end of each output file:

        PWSCF        :   3m26.15s CPU   3m30.27s WALL

and plot TIME(npool). Which is the best npool value? Why?

4. You can try with different numbers of MPI tasks.
