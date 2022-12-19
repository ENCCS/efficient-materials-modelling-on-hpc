Efficient materials modelling on HPC with Quantum ESPRESSO, Yambo and BigDFT
============================================================================

In recent years, computing technologies underlying materials modelling and 
electronic structure calculation have evolved rapidly. High-performance 
computing (HPC) is transitioning from petascale to exascale, while individual 
compute nodes are increasingly based on heterogeneous architectures that every 
year become more diversified due to different vendor choices. In this environment, 
electronic structure codes also have to evolve fast in order to adapt to new 
hardware facilities. Nowadays, state-of-the-art electronic structure codes based 
on modern density functional theory (DFT) methods allow treating realistic 
molecular systems with a very high accuracy. However, due to the increased 
complexity of the codes, some extra skills are required from users in order to 
fully exploit their potential.  

This training material gives a broad overview of important fundamental concepts 
for molecular and materials modelling on HPC, with a focus on three of the most 
modern codes for electronic structure calculations (QUANTUM ESPRESSO, Yambo and 
BigDFT). Theory sections are interleaved with practical demonstrations and 
hands-on exercises.

`QUANTUM ESPRESSO <https://www.quantum-espresso.org/>`__ is one of the most 
popular suites of computer codes for electronic-structure calculations and 
materials modelling at the nanoscale, based on density-functional theory, plane 
waves, and pseudopotentials. It is able to predict and give fundamental insights 
about many properties of materials, molecular systems, micro and nanodevices, 
biological systems, in many fields, providing a huge amount of data for 
data-driven science applications.

`YAMBO <http://www.yambo-code.eu/>`__ is an open-source code implementing 
first-principles methods based on Green’s function (GF) theory to describe 
excited-state properties of realistic materials. These methods include the GW 
approximation, the Bethe Salpeter equation, nonequilibrium GF (NEGF) and TDDFT, 
allowing for the prediction of accurate quasiparticle energies (e.g. ARPES band 
structures), linear and non-linear optical properties, capturing the physics of 
excitons, plasmons, and magnons. It is also possible to calculate 
temperature-dependent electronic and optical properties via electron-phonon 
coupling and nonequilibrium and non-linear optical properties via NEGF real-time 
simulations (pump-probe experiments, etc).

`BigDFT <http://www.bigdft.org/>`__ is an open source density functional theory 
code which uses a Daubechies wavelet basis set which facilitates optimal features 
of flexibility, performance and precision. In addition to the traditional 
cubic-scaling DFT approach, BigDFT also contains an approach which scales 
linearly with the number of atoms, enabling DFT calculations of large systems 
containing many thousands of atoms which were impractical to simulate even very 
recently. BigDFT consists of a package suite with a wide variety of features, 
from ground-state quantities to excited state quantities based on time-dependent 
DFT and constrained DFT, to potential energy surface exploration techniques. 
It uses dual space Gaussian type norm-conserving pseudopotentials including those 
with non-linear core corrections, which have proven to deliver all-electron 
precision. Its flexible Poisson solver can handle a number of different boundary 
conditions including free, wire, surface, and fully periodic, while it is also 
possible to simulate implicit solvents as well as external electric fields. 
Finally, BigDFT has been designed to exploit HPC from the outset, with a hybrid 
MPI/OpenMP approach, as well as efficient exploitation of GPUs for hybrid 
functional calculations.

`MAX (MAterials design at the eXascale) <http://www.max-centre.eu/>`__ is a 
European Centre of Excellence which enables materials modelling, simulations, 
discovery and design at the frontiers of the current and future High-Performance 
Computing (HPC), High Throughput Computing (HTC) and data analytics technologies.  
MaX's challenge lies in bringing the most successful and widely used open-source, 
community codes in quantum simulations of materials towards exascale and extreme 
scaling performance and make them available for a large and growing base of 
researchers in the materials' domain.


.. prereq::

   - Some familiarity with density functional theory (DFT), self-consistent 
     field (SCF) calculations and plane wave basis sets is desirable as the 
     workshop will not cover the fundamental theory of these topics.
   - Familiarity with working in a Linux environment and some experience with 
     working on an HPC system is needed to participate in the hands-on exercises.



.. toctree::
   :maxdepth: 1
   :caption: Day 1 - MAX-CoE and Quantum ESPRESSO

   lectures-1
   espresso-tutorial

.. toctree::
   :maxdepth: 1
   :caption: Day 2 - Quantum ESPRESSO and AiiDA

   lectures-2
   espresso-tutorial-phonons


.. toctree::
   :maxdepth: 1
   :caption: Day 3 - Yambo

   lectures-3
   yambo-tutorial


.. toctree::
   :maxdepth: 1
   :caption: Day 4 - BigDFT

   lectures-4
   code/bigdft/1.SystemGenFirstCalcs
   code/bigdft/2.RemoteManagerInitialTutorial
   code/bigdft/3.CubicScaling-H2O
   code/bigdft/4.LinearScaling-H2O

.. toctree::
   :maxdepth: 1
   :caption: Reference

   quick-reference
   guide



.. _learner-personas:

Who is the course for?
----------------------

This workshop is aimed towards researchers and engineers who already have some 
previous experience with materials modelling and electronic structure calculations.


About the course
----------------

In this workshop, participants will learn how to launch the most common 
types of calculations  (e.g. scf, phonons, quasi-particle energies, 
time-dependent properties) using QE, Yambo and BigDFT, how to prepare input 
files and how to read output files in order to extract the desired properties.

Best practices for efficient exploitation of HPC resources will be discussed, 
with particular emphasis on how to use the different schemes of data 
distribution (e.g. plane waves, pools, images) in combination with the different 
parallelization and acceleration schemes (MPI, OpenMP, GPU-offload) available in 
QE. 

Schedule for 4 half-day workshop
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Day 1, QUANTUM ESPRESSO**

+------------+-------------------------------------------------------+
| Time       | Section                                               | 
+============+=======================================================+
|09:00-09:15 | Welcome and introduction to ENCCS                     |
+------------+-------------------------------------------------------+
|09:15-09:30 | Introduction to Max-CoE and MaX flagship codes        |
+------------+-------------------------------------------------------+
|09:30-10:00 | Overview of the QE suite of codes, and main features  |
+------------+-------------------------------------------------------+
|10:00-10:20 | Coffee break                                          |
+------------+-------------------------------------------------------+
|10:20-13:00 | PWSCF for HPC and GPU                                 |
+------------+-------------------------------------------------------+


**Day 2, QUANTUM ESPRESSO and AiiDA**

+------------+----------------------------------------------------------------------+
| Time       | Section                                                              | 
+============+======================================================================+
|09:00-09:45 | Introduction to Density Functional Perturbation Theory               |
+------------+----------------------------------------------------------------------+
|09:45-10:15 | Introduction to Time Dependent Density Functional Perturbation Theory|
+------------+----------------------------------------------------------------------+
|10:15-10:25 | Coffee break                                                         |
+------------+----------------------------------------------------------------------+
|10:25-12:15 | Phonons and time dependent properties on HPC and GPU                 |
+------------+----------------------------------------------------------------------+
|12:15-13:00 | Introduction to AiiDA for HPC                                        |
+------------+----------------------------------------------------------------------+

**Day 3, Yambo**

+------------+------------------------------------------------------------------+
| Time       | Section                                                          | 
+============+==================================================================+
|09:00-09:20 | Overview of the Yambo code and its main features and performance |
+------------+------------------------------------------------------------------+
|09:20-10:00 | Introduction to the GW approximation                             |
+------------+------------------------------------------------------------------+
|10:00-10:20 | Coffee break                                                     |
+------------+------------------------------------------------------------------+
|10:20-13:00 | Hands-on tutorial: A guided tour through GW simulations          |
+------------+------------------------------------------------------------------+

**Day 4, BigDFT**

+------------+-------------------------------------------------------+
| Time       | Section                                               | 
+============+=======================================================+
|09:00-09:30 | Introduction to BigDFT                                |
+------------+-------------------------------------------------------+
|09:30-10:00 | Introduction to PyBigDFT: System Manipulation         |
+------------+-------------------------------------------------------+
|10:00-10:30 | Remote Runner (Presentation & Walkthrough/Hands-on)   |
+------------+-------------------------------------------------------+
|10:30 - 11:00 | Coffee break                                        |
+------------+-------------------------------------------------------+
|11:00 - 12:00 | Cubic Scaling BigDFT (Hands-on)                     |
+------------+-------------------------------------------------------+
|12:00 - 13:00 | Linear Scaling BigDFT (Hands-on)                    |
+------------+-------------------------------------------------------+



See also
--------

- ENCCS: https://enccs.se/
- MAX-CoE: http://www.max-centre.eu/
- Follow ENCCS on `LinkedIn <https://www.linkedin.com/company/enccs>`__, or `Twitter <https://twitter.com/EuroCC_Sweden>`__
- Follow MAX-CoE on `LinkedIn <https://www.linkedin.com/company/max-centre/>`__, or `Twitter <https://twitter.com/max_center2>`__.

.. math::


Credits
-------

Contributors to this workshop:

- Daniele Varsano, CNR-NANO
- Andrea Ferretti, CNR-NANO
- Pietro Delugas, SISSA
- Ivan Carnimeo, SISSA 
- Fabrizio Ferrari Ruffino, CNR-IOM
- Stefano Baroni, SISSA
- Iurii Timrov, EPFL CH
- Laura Bellentani, CINECA
- Oscar Baseggio, SISSA
- Tommaso Gorni, CINECA
- Francisco Ramirez, EPFL
- Davide Sangalli CNR-ISM
- Fulvio Paleari, CNR-NANO
- Ignacio Alliati, Univ. Bellfast
- Martina Stella, ICTP
- Nicola Spallanzani, CNR-NANO
- Laura Ratcliff, Univ. of Bristol
- Luigi Genovese, CEA Grenoble
- Louis Beal, CEA Grenoble
- Samuel Dechamps, CEA Grenoble 

The lesson file structure and browsing layout is inspired by and derived from
`work <https://github.com/coderefinery/sphinx-lesson>`__ by `CodeRefinery
<https://coderefinery.org/>`__ licensed under the `MIT license
<http://opensource.org/licenses/mit-license.html>`__. We have copied and adapted
most of their license text.

Instructional Material
^^^^^^^^^^^^^^^^^^^^^^

This instructional material is made available under the
`Creative Commons Attribution license (CC-BY-4.0) <https://creativecommons.org/licenses/by/4.0/>`__.
The following is a human-readable summary of (and not a substitute for) the
`full legal text of the CC-BY-4.0 license
<https://creativecommons.org/licenses/by/4.0/legalcode>`__.
You are free to:

- **share** - copy and redistribute the material in any medium or format
- **adapt** - remix, transform, and build upon the material for any purpose,
  even commercially.

The licensor cannot revoke these freedoms as long as you follow these license terms:

- **Attribution** - You must give appropriate credit (mentioning that your work
  is derived from work that is Copyright (c) ENCCS and individual contributors and, where practical, linking
  to `<https://enccs.github.io/sphinx-lesson-template>`_), provide a `link to the license
  <https://creativecommons.org/licenses/by/4.0/>`__, and indicate if changes were
  made. You may do so in any reasonable manner, but not in any way that suggests
  the licensor endorses you or your use.
- **No additional restrictions** - You may not apply legal terms or
  technological measures that legally restrict others from doing anything the
  license permits.

With the understanding that:

- You do not have to comply with the license for elements of the material in
  the public domain or where your use is permitted by an applicable exception
  or limitation.
- No warranties are given. The license may not give you all of the permissions
  necessary for your intended use. For example, other rights such as
  publicity, privacy, or moral rights may limit how you use the material.


Software
^^^^^^^^

Except where otherwise noted, the example programs and other software provided
with this repository are made available under the `OSI <http://opensource.org/>`__-approved
`MIT license <https://opensource.org/licenses/mit-license.html>`__.
