#!/bin/bash
# Setup
source /opt/ros/groovy/setup.bash >&1

# variables
WORKSPACE=$1
JOB_WORKSPACE_FILE=$2

#echo "============ Initializing and building catking workspace =============" >&1

# initializing ros workspace 
#echo "creating workspace in path: $WORKSPACE" >&1
mkdir -p "$WORKSPACE/src" # creating source directory for catkin workspace
cd $WORKSPACE # entering job workspace
capture_stdout=$(rosws init ${WORKSPACE})

#initializing catking workspace
cd "$WORKSPACE/src"
capture_stdout=$(catkin_init_workspace)

#building catkin workspace 
cd $WORKSPACE
capture_stdout=$(catkin_make)

# merging workspaces
capture_stdout=$(cat $WORKSPACE/devel/.rosinstall | rosws merge - )
capture_stdout=$(rosws merge ${JOB_WORKSPACE_FILE} -y )

# cloning all git repositories in src directory
capture_stdout=$(rosws update -v )

# changing mode of workpace
chmod a+rwx -R ${WORKSPACE}

