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
```{literalinclude} code/Day-2/exercise_ph/inputs/pw.CnSnI3.in 
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


#### Solution

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

### Phonon calculation, step2
 
**Files needed**:

`````{tabs} 
````{tab} submit.slurm 
```{literalinclude} code/Day-2/exercise_ph/step2/submit.slurm
:language: bash
:linenos:
```
````
````{tab} ph.CnSnI3.in
```{literalinclude} code/Day-2/exercise_ph/inputs/ph.CnSnI3.in
```
````
`````

Perform a phonon calculation at Gamma for CnSnI3 using the `ph.x` program.

1. Copy `../inputs/ph.CnSnI3.in` in the current folder and modify the `&inputph` namelist ; add coordinates of the Gamma point

	```
   	&inputph
		prefix=''
		amass(1)=
		amass(2)=
		amass(3)=
	/
	X	Y	Z
	```

2. Submit the jobfile to run `ph.x` on 1 MPI : GPU

3. Check the number of k points

	`awk '/number of k/' ph.CnSnI3.out`

4. Check the number of irreducible representations

	`awk '/irreducible/' ph.CnSnI3.out`

5. Check the dynamical matrix in dynmat.out

	`tail -n 97 harmdyn_support`


#### Solution

``````{solution}
`````{tabs} 
````{tab} submit.slurm 
```{literalinclude} code/Day-2/exercise_ph/step2/reference/submit.slurm
:language: bash
:linenos:
```
````
````{tab} ph.CnSnI3.in
```{literalinclude} code/Day-2/exercise_ph/step2/reference/ph.CnSnI3.in
```
````
`````
``````


### ASR rule application, step 3
 
**Files needed**:

`````{tabs} 
````{tab} submit.slurm 
```{literalinclude} code/Day-2/exercise_ph/step3/submit.slurm
:language: bash
:linenos:
```
````
````{tab} dyn.CnSnI3.in
```{literalinclude} code/Day-2/exercise_ph/inputs/dyn.CnSnI3.in
```
````
`````

Apply the Acoustic Sum Rule (ASR) with `dynmat.x`

1. Copy `../inputs/dyn.CnSnI3.in` and add the `‘crystal’` ASR rule

	```
	&input
		asr=''
	```

2. Copy `../step2/harmdyn_support` in the current folder

3. Submit the job 

4. Check phonon frequencies with ASR rule applied in `dyn.CnSnI3.out`


#### Solution

``````{solution}
`````{tabs} 
````{tab} dyn.CnSnI3.in
```{literalinclude} code/Day-2/exercise_ph/step3/reference/dyn.CnSnI3.in
```
````
````{tab} dyn.CnSnI3.out
```{literalinclude} code/Day-2/exercise_ph/step3/reference/dyn.CnSnI3.out
```
````
`````
``````

## Multi GPU offload with pools, step 4 
 
**Files needed**:

`````{tabs} 
````{tab} submit.slurm 
```{literalinclude} code/Day-2/exercise_ph/step4/submit.slurm
:language: bash
:linenos:
```
````
`````

Perform a phonon calculation at Gamma on 2 GPUs for CnSnI3 using the `ph.x` program.

1. Copy the input of step2 `../step2/ph.CnSnI3.in` in the current folder

2. Copy the `../step1/out` directory in the current folder

3. Modify `npools` in `submit.slurm` to distribute the calculation on 2 MPIs : GPUs with pool parallelization

4. Submit the jobfile

	`sbatch submit.slurm`

5. Check wall time of parallel execution

	`tail ph.CnSnI3.out`

#### Solution

``````{solution}
`````{tabs} 
````{tab} submit.slurm
```{literalinclude} code/Day-2/exercise_ph/step4/reference/submit.slurm
:language: bash
:linenos:
```
````
````{tab} ph.CnSnI3.in
```{literalinclude} code/Day-2/exercise_ph/step4/reference/ph.CnSnI3.in
```
````
`````
``````

