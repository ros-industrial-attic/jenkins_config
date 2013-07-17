#!/bin/bash
# Setup
source /opt/ros/groovy/setup.bash

# variables
WORKSPACE=$1
JOB_WORKSPACE_FILE=$2

echo "============ Initializing and building catking workspace =============" > &1

# initializing ros workspace to track git repositories
echo "creating workspace in path: $WORKSPACE" &1
mkdir -p "$WORKSPACE/src" # creating source directory for catkin workspace
cd $WORKSPACE # entering job workspace
rosws init ${WORKSPACE} ${JOB_WORKSPACE_FILE}

#initializing catking workspace
cd "$WORKSPACE/src"
catkin_init_workspace

#building catkin workspace 
cd $WORKSPACE
catkin_make

# merging catkin workspace
cat $WORKSPACE/devel/.rosinstall | rosws merge -

# cloning all git repositories in src directory
rosws update -v > &1

