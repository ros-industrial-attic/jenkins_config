#!/bin/bash

# variables
SETUP_FILE=$WORKSPACE"/setup.bash"

#sourcing setup file
echo "sourcing workspace setup script"
source $SETUP_FILE

echo "============ Building catkin workspace ============"
catkin_make clean
catkin_make run_tests 


