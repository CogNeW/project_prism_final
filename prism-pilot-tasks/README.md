# PRISM Pilot Tasks
Repository for the tasks to be administered in the PRISM Pilot study, as well as scripts used to parse behavioral data that is output from the tasks upon completion.

## Technologies
The tasks were created with:
* MATLAB
* PsychoPy

Scripts were written in:
* MATLAB
* Python

## Setup: 
To run tasks download the repository to your desired directory.
a. Navon and Stroop:
The Navon and Stroop tasks need to be loaded from MATLAB.
1) Open MATLAB and make the working directory the path to the `PRISM_Pilot_Tasks/` folder located in the repo. 
2) run the `run_this.m` script, confirming that it is in your working directory. This top-level wrapper script handles reading from the subject randomizer list and loading the Navon and Stroop tasks.

b. n-back:
The n-Back task needs to be loaded from PsychoPy. 
1)	Open the appropriate instruction slides from the Instructions folder.
2)	Walk through the slides and ensure the participant understands the experiment.
3)	Open PsychoPy and from the PsychoPy Builder go File -> Open select nback_exp.psyexp  (for the experiment) or the nback_prac.psyexp from n_back folder.
4)	Click the ‘Run Experiment’ button (white play button in green circle)
5)	Enter Subject ID and fill in the appropriate Session # (based of counterbalance and instructions showed).
a.	Session # can either be 1,2,3,4
b.	Difference between various session #s is the block order. There are a total of 4 blocks for each trial type (0-back, 1-back, 2-back). Each participant will see all 4 trial types throughout the experiment, but the order they are presented changes as a function of block order.
6)	If you need to exit out of the experiment at any of time hit the ‘esc’ key. Note that whatever data you were able to collect will be saved.

