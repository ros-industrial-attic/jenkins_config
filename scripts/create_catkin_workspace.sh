#!/bin/bash

# variables
WORKSPACE=$1
JOB_WORKSPACE_FILE=$2

# initializing ros workspace 
mkdir -p "$WORKSPACE" 
cd $WORKSPACE # entering job workspace
capture_stdout=$(rosws init ${WORKSPACE})
capture_stdout=$(rosws merge ${JOB_WORKSPACE_FILE} -y)
source "$WORKSPACE/setup.bash" # sources ros distro setup.bash 

# initializing catkin workspace
mkdir -p "$WORKSPACE/src" 
cd "$WORKSPACE/src"
capture_stdout=$(catkin_init_workspace)

#building catkin workspace 
#cd $WORKSPACE
#capture_stdout=$(catkin_make)

# merging workspaces
#capture_stdout=$(cat $WORKSPACE/devel/.rosinstall | rosws merge - )

# cloning all git repositories in src directory
cd $WORKSPACE
capture_stdout=$(rosws update -v )



