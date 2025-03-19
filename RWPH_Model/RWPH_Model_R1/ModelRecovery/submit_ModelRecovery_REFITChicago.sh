#!/bin/bash

submit_file=all_FLANKER.submit  	# submit file for condor

cdir=`pwd`         # get the path to current working directory

if [ ! -d $cdir/log ] # create directory for condor log files
then
    mkdir $cdir/log
fi

# create header for the condor submit file
echo "Executable = /usr/bin/matlab
Universe = vanilla
initialdir = $cdir
request_cpus = 1
request_memory = 1000
notification = never
getenv = True
" > $submit_file
# requirements = Machine == \"snake2.local\"  || Machine == \"snake5.local\" || Machine == \"snake7.local\" || Machine == \"snake10.local\" || Machine == \"snake11.local\"
#RANK = TARGET.CPUVendor == "Intel"
# create a queue with each fsf file found in the current directory

for i in {1..97}
	do
    	echo "arguments = -r A01_ModelRecov_RWPH_func($i)" >> $submit_file
   		echo "error  = $cdir/log/subj$im$m$c.error\$(Process)" >> $submit_file
    	echo "output = $cdir/log/subj$im$m$c.out\$(Process)" >> $submit_file
    	echo "Queue" >> $submit_file
done


condor_submit $submit_file
