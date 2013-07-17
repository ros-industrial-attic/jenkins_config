#!/bin/bash
# Setup
source /opt/ros/groovy/setup.bash

# variables
SETUP_FILE=$WORKSPACE"/setup.bash"

#sourcing setup file
source $SETUP_FILE

#updating repositories
cd $WORKSPACE
rosws update -v

echo "============ Building catkin workspace ============"
catkin_make clean
catkin_make 


