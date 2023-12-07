# Tutorial: Quantum ESPRESSO on HPC systems

```{callout} Credit
This material is adapted with permission from 
https://gitlab.com/QEF/materials-for-max-coe-enccs-workshop-2022
```

{download}`Slides <slides/Handson-Day1.pdf>`


## Setup

- Download the pseudopotentials: {download}`data/materials-for-max-coe-enccs-workshop-2022-v0.9-pseudo.tar.gz`

---

## EXERCISE 0 - First serial run

**Files needed**:

`````{tabs} 
````{tab} ex0-run.slurm template
```{literalinclude} code/Day-1/ex0-run/ex0-run.slurm
:language: bash
:linenos:
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
:linenos:
```
````
````{tab} atom-pbe.out
```{literalinclude} code/Day-1/ex0-run/reference/atom-pbe.out
```
````
`````
``````

---

## EXERCISE 1 - Parallelization with pools

**Files needed**:

`````{tabs} 
````{tab} ex1-pools.slurm template
```{literalinclude} code/Day-1/ex1-pools/ex1-pools.slurm
:language: bash
:linenos:
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

---

## EXERCISE 2 - Parallelization of the eigenvalue problem

**Files needed**:

`````{tabs} 
````{tab} ex2-diag.slurm template
```{literalinclude} code/Day-1/ex2-diag/ex2-diag.slurm
:language: bash
:linenos:
```
````
````{tab} pw.CuO.scf.in
```{literalinclude} code/Day-1/inputs/pw.CuO.scf.in
```
````
`````

Play with the `ndiag` parameter by performing a number of runs and seeing variations in the WALL time (if any).  
You can also change the fixed value of npools (the default value for this exercise is 4).

1. Replace the dots with a list of proper values for ndiag, e.g:
   ```bash
   for id in 1 2 3 4 5 6     # not necessarily the right values here!
   do
   ```

2. Submit the job file:
   ```console
   $ sbatch ./ex2-diag.slurm
   ```

3. Check the total WALL time at the end of the output file and plot TIME(ndiag).  
   Which is the best `ndiag` value (if any)? Why?

### Solution

````{solution}
pw_CuO_4diag.out:

```{literalinclude} code/Day-1/ex2-diag/reference/pw_CuO_4diag.out
:language: shell
```
````

--- 

## EXERCISE 3 - MPI + OpenMP parallelization

**Files needed**:

`````{tabs} 
````{tab} ex3-omp.slurm
```{literalinclude} code/Day-1/ex3-omp/ex3-omp.slurm
:language: bash
:linenos:
```
````
``````

Find out how to best exploit the available CPU resources, by playing with the MPI-related parameters (number of tasks, npools) together with the number of threads.  
Use the batch file `ex3-omp.slurm` to submit your jobs (modify it at your convenience).  
Hints:

0. Know the size of your node, e.g. the amount of cores at your disposal;

1. See how the time scaling of your jobs changes just by varying the number of tasks (keep just 1 thread each at first).  
   Adapt the `npool` parameter at each run.

2. Now you can start to explore the OpenMP parallelization by varying the number of threads (avoid hyperthreading).

3. Do multiple WALL_TIME plots in function of the number of MPI tasks and OpenMP threads.
   Which is the best configuration for this exercise?

### Solution

``````{solution}
`````{tabs} 
````{tab} ex3-omp.slurm
```{literalinclude} code/Day-1/ex3-omp/reference/ex3-omp.slurm
:language: bash
:linenos:
```
````
````{tab} pw_run16x1.out
```{literalinclude} code/Day-1/ex3-omp/reference/pw_run16x1.out
```
````

````{tab} pw_run16x2.out
```{literalinclude} code/Day-1/ex3-omp/reference/pw_run16x2.out
```
````

````{tab} pw_run16x4.out
```{literalinclude} code/Day-1/ex3-omp/reference/pw_run16x4.out
```
````

`````
``````

## EXERCISE 4 - Hands on the GPUs

**Files needed**:

`````{tabs} 
````{tab} ex4-cpu.slurm
```{literalinclude} code/Day-1/ex4-gpu/ex4-cpu.slurm
:language: bash
:linenos:
```
````
````{tab} ex4-gpu.slurm
```{literalinclude} code/Day-1/ex4-gpu/ex4-gpu.slurm
:language: bash
:linenos:
```
````
`````

Test the power of the GPUs (roughly).

0. Know the size of your node. Look at: https://doc.vega.izum.si/general-spec/  
   How many cores? How many GPUs?

1. Use the batch file `ex4-gpu.slurm` to submit a few MPI+GPU runs. You can also check what happens with more MPI tasks than GPUs.  
   Dots at lines 7, 9, 10, 25, 27, 29.

2. Enable openMP threading. Do you see any improvement?
   
3. Consider your best CPU run. How many GPUs were necessary to match the performance?  
   If you don't have your optimized CPU batch file from exercise 3 you can use the one in the reference folder.

### Solution

``````{solution}
`````{tabs} 
````{tab} ex4-cpu.slurm
```{literalinclude} code/Day-1/ex4-gpu/reference/ex4-cpu.slurm
:language: bash
:linenos:
```
````
````{tab} ex4-gpu.slurm
```{literalinclude} code/Day-1/ex4-gpu/reference/ex4-gpu.slurm
:language: bash
:linenos:
```
````
````{tab} pw.CnSnI3.cpu.out
```{literalinclude} code/Day-1/ex4-gpu/reference/pw.CnSnI3.cpu.out
```
````
````{tab} pw.CnSnI3_gpu.out
```{literalinclude} code/Day-1/ex4-gpu/reference/pw.CnSnI3_gpu.out
```
````
`````
``````