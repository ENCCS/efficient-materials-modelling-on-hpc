EXERCISE 4 - Hands on the GPUs
===============================================

Test the power of the GPUs (roughly).

0. Know the size of your node. Look at: https://doc.vega.izum.si/general-spec/  
   How many cores? How many GPUs?

1. Use the batch file 'ex4-gpu.slurm' to submit a few MPI+GPU runs. You can also check what happens with more MPI tasks than GPUs.  
   Dots at lines 7, 9, 10, 25, 27, 29.

2. Enable openMP threading. Do you see any improvement?
   
3. Consider your best CPU run. How many GPUs were necessary to match the performance?  
   If you don't have your optimized CPU batch file from exercise 3 you can use the one in the reference folder.
