#!/bin/bash
# Setup
source /opt/ros/groovy/setup.bash

# branch
BRANCH_NAME=$1

# checking if catkin ws is already initialized
cd $WORKSPACE # entering job workspace
JOB_SCRIPTS_PATH=${JENKINS_HOME}/jobs/${JOB_NAME}/scripts
SETUP_FILE=$WORKSPACE"/devel/setup.bash"
if [ -f $SETUP_FILE ];
then
	echo "============ Building catkin workspace ============"
	#sourcing setup file
	source $SETUP_FILE
	cd "$WORKSPACE/devel"
	#rosws update ../src/industrial_core < <(echo "d")
	rosws update -v

	cd $WORKSPACE
	catkin_make clean
	catkin_make 
else
	echo "============ Initializing and building catking workspace ============="

	#initializing catking workspace
	cd "$WORKSPACE/src"
	catkin_init_workspace

	#building workspace
	cd $WORKSPACE
	catkin_make

	# setting up .rosinstall file
	#rosws set ../src/industrial_core/ --git https://github.com/ros-industrial/industrial_core.git -y
	
	cd "$WORKSPACE/devel"
	cat "$JOB_SCRIPTS_PATH/repository_list.txt" | awk -F',' '{system("rosws set "$1" --git "$2" -v "$3" -y "); print "added repository ", $2, " in local path ", $1}'

	#sourcing setup file
	source $SETUP_FILE	
	
fi
