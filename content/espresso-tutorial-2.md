# Quantum ESPRESSO tutorial 2

## Phonons for HPC and GPUs

{download}`Slides <slides/Handson-Day2.pdf>`


## EXERCISE - Phonon modes of CnSnI3 at Gamma

### pwscf simulation, step 1 

**Files needed**:

`````{tabs} 
````{tab} submit.slurm template
```{literalinclude} code/Day-2/exercise_ph/step1/submit.slurm
:language: bash
:linenos:
```
````
````{tab} pw.CnSnI3.in 
```{literalinclude} code/Day-2/exercise_ph/inputs/atom-pbe.in
```
````
`````

Perform a vc-relax calculation for CnSnI3  using the `pw.x` program.

1. Copy `../inputs/pw.CnSnI3.in` in the current folder and modify the `&CONTROL` namelist to do a vc-relax calculation

   `calculation=""`

2. Open `submit.slurm` and modify npw to use R&G on 4 MPIs:GPUs

3. Submit the job file

   `sbatch submit.slurm`

   Check if convergence has been achieved.

4. Copy the output directory (`out/`)in the folder of step2.

   `cp -r ./out ../step2/`


### Solution

``````{solution}
`````{tabs} 
````{tab} submit.slurm 
```{literalinclude} code/Day-2/exercise_ph/step1/reference/submit.slurm
:language: bash
:linenos:
```
````
````{tab} pw.CnSnI3.in
```{literalinclude} code/Day-2/exercise_ph/step1/reference/pw.CnSnI3.in
```
````
`````
``````

