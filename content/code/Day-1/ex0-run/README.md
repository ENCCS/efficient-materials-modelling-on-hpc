EXERCISE 0 - First serial run
=================================================

We will only use pw.x for this hands-on.  
The build-in module of QEv7.1 is loaded in the batch file:

        module load QuantumESPRESSO/7.1-foss-2022a

Check that the module works by submitting a quick serial test.  
Open the Slurm batch file, fill the dots with the right numbers/commands (dots at lines 7, 8, 10, 23, 25) and submit it:

        sbatch ./ex0-run.slurm

To see the submission status of your job:

        squeue -u YOUR_USERNAME
