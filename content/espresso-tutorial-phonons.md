# Tutorial: Phonons, EELS and magnons for HPC and GPUs

{download}`Slides <slides/Handson-Day2.pdf>`

## Phonon modes of CnSnI3 at Gamma

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

### Multi GPU offload with pools, step 4 
 
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

### Multi gpu offload with images, step 5 

**Files needed**:

`````{tabs} 
````{tab} submit.slurm 
```{literalinclude} code/Day-2/exercise_ph/step5/submit.slurm
:language: bash
:linenos:
```
````
````{tab} dyn.CnSnI3.in
```{literalinclude} code/Day-2/exercise_ph/inputs/dyn.CnSnI3.in
```
````
`````


 
Perform a phonon calculation at Gamma on 4 GPUs for CnSnI3 using the `ph.x` program.

1. Copy the input of step2 `../step2/ph.CnSnI3.in`

2. Copy `ph.CnSnI3.in` as `ph.CnSnI3.recover.in` and add `recover=.true.` in `&inputph`

3. Copy the `../step1/out` directory in the current folder

4. Modify `nimages` in `submit.slurm` to distribute the calculation on 4 MPIs : GPUs with image parallelization
 
5. Submit the jobfile

	`sbatch submit.slurm`

6. With image parallelism there is 1 output file for each image. These are named `out.*_0`, with * the image rank. 
   Check the workload of each image
   ```console
   $ awk '/I am image/ {x=NR+3} (NR<=x) {print $0} ' out.*_0
   ```

6. Compare wall times. Which images takes the longest time ? Why ?

#### Solution

``````{solution}
`````{tabs} 
````{tab} submit.slurm
```{literalinclude} code/Day-2/exercise_ph/step5/reference/submit.slurm
:language: bash
:linenos:
```
````
`````
``````

---

## EELS in bulk Silicon

Calculation of the electron energy loss spectra (EELS) of bulk silicon.

**Submit files needed**:

`````{tabs} 
````{tab} submit_pw.slurm 
```{literalinclude} code/Day-2/example-eels/submit_pw.slurm
:language: bash
:linenos:
```
````
````{tab} submit_eels.slurm 
```{literalinclude} code/Day-2/example-eels/submit_eels.slurm
:language: bash
:linenos:
```
````
````{tab} submit_spectrum.slurm 
```{literalinclude} code/Day-2/example-eels/submit_spectrum.slurm
:language: bash
:linenos:
```
````
`````

**Input files needed**:

`````{tabs} 
````{tab} pw.Si.scf.in
```{literalinclude} code/Day-2/example-eels/pw.Si.scf.in
```
````
````{tab} turbo_eels.Si.tddfpt.in 
```{literalinclude} code/Day-2/example-eels/turbo_eels.Si.tddfpt.in
```
````
````{tab} turbo_spectrum.Si.pp.in
```{literalinclude} code/Day-2/example-eels/turbo_spectrum.Si.pp.in
```
````
`````

Step-by-step for running the tutorial can be found in the slides linked at the top of this page!

---

## Calculation of the magnon spectra of bulk iron

**Submit files needed**:

`````{tabs} 
````{tab} submit_pw.slurm 
```{literalinclude} code/Day-2/example-magnon/submit_pw.slurm
:language: bash
:linenos:
```
````
````{tab} submit_magnon.slurm 
```{literalinclude} code/Day-2/example-magnon/submit_magnon.slurm
:language: bash
:linenos:
```
````
````{tab} submit_spectrum.slurm 
```{literalinclude} code/Day-2/example-magnon/submit_spectrum.slurm
:language: bash
:linenos:
```
````
`````

**Input files needed**:

`````{tabs} 
````{tab} pw.Fe.scf.in
```{literalinclude} code/Day-2/example-magnon/pw.Fe.scf.in
```
````
````{tab} turbo_magnon.Fe.tddfpt.in 
```{literalinclude} code/Day-2/example-magnon/turbo_magnon.Fe.tddfpt.in
```
````
````{tab} turbo_spectrum.Fe.pp.in
```{literalinclude} code/Day-2/example-magnon/turbo_spectrum.Fe.pp.in
```
````
`````

Step-by-step for running the tutorial can be found in the slides linked at the top of this page!
