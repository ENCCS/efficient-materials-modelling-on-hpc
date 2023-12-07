EXERCISE MAGNONS
=================================================
Calculation of the magnon spectra of bulk iron


Step 1) Run the SCF ground-state calculation with pw.x

        sbatch submit_pw.slurm

Step 2) Perform Lanczos recursions with turbo_magnon.x

        sbatch submit_eels.slurm

Step 3) Run the post-processing spectrum calculation with turbo_spectrum.x

        sbatch submit_spectrum.slurm

