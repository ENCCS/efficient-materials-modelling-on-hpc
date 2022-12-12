# Quantum ESPRESSO tutorial I

```{callout} Credit
This material is adapted with permission from 
https://gitlab.com/QEF/materials-for-max-coe-enccs-workshop-2022
```

## QUANTUM ESPRESSO on HPC systems

{download}`Slides <slides/Handson-Day1.pdf>`


## Setup

- Download the pseudopotentials: {download}`data/materials-for-max-coe-enccs-workshop-2022-v0.9-pseudo.tar.gz`


## EXERCISE 0 - First serial run

**Files needed**:

`````{tabs} 
````{tab} ex0-run.slurm template
```{literalinclude} code/Day-1/ex0-run/ex0-run.slurm
:language: bash
```
````
````{tab} atom-pbe.in 
```{literalinclude} code/Day-1/inputs/atom-pbe.in
```
````
`````

We will only use `pw.x` for this hands-on.  
The build-in module of QEv7.1 is loaded in the batch file:

```console
$ module load QuantumESPRESSO/7.1-foss-2022a
```

Check that the module works by submitting a quick serial test.  
Open the Slurm batch file, fill the dots with the right numbers/commands (dots at lines 7, 8, 10, 23, 25) and submit it:

```console
$ sbatch ./ex0-run.slurm
```

To see the submission status of your job:

```console
$ squeue -u YOUR_USERNAME
```

### Solution

``````{solution}
`````{tabs} 
````{tab} ex0-run.slurm 
```{literalinclude} code/Day-1/ex0-run/reference/ex0-run.slurm
:language: bash
```
````
````{tab} atom-pbe.out
```{literalinclude} code/Day-1/ex0-run/reference/atom-pbe.out
```
````
`````
``````

## EXERCISE 1 - Parallelization with pools

**Files needed**:

`````{tabs} 
````{tab} ex1-pools.slurm template
```{literalinclude} code/Day-1/ex1-pools/ex1-pools.slurm
:language: bash
```
````
````{tab} pw.CuO.scf.in
```{literalinclude} code/Day-1/inputs/pw.CuO.scf.in
```
````
`````

Try to predict the best value of npool and check by performing a number of runs.

1. Open the batch file `ex1-pools.slurm` and customize the user-related SLURM options like job-name and mail-user (not essential at all);  
Replace the dots with a list of proper values for npool, e.g:
       
   ```bash       
   for ip in 1 2 3 4 5 6    # not the necessarily the right values here!
   do
   ```

2. Submit the job file:

   ```console
   $ sbatch ./ex1-pools.slurm
   ```

3. Look for total WALL time at the end of each output file:

   ```
           PWSCF        :   3m26.15s CPU   3m30.27s WALL
   ```

   and plot `TIME(npool)`. Which is the best npool value? Why?

4. You can try with different numbers of MPI tasks.

### Solution

````{solution}
pw_CuO.out:

```{literalinclude} code/Day-1/ex1-pools/reference/pw_CuO.out
:language: shell
```
````