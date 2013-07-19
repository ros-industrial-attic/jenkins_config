#!/bin/bash
# Setup
source /opt/ros/groovy/setup.bash

# variables
SETUP_FILE=$WORKSPACE"/setup.bash"
ROS_INSTALL_FILE=${JENKINS_HOME}/jenkins_config/workspaces/${JOB_NAME}.rosinstall

# merging workspace file
if [ -f $ROS_INSTALL_FILE ];
then
	echo "merging workspace file $ROS_INSTALL_FILE"
	cd ${WORKSPACE}
	rosws merge ${ROS_INSTALL_FILE} -r -y
else
	echo "workspace .rosinstall file not found, skip merge"
fi

#sourcing setup file
echo "sourcing setup"
source $SETUP_FILE

#updating repositories
cd $WORKSPACE
rosws update --delete-changed-uris -v

echo "============ Building catkin workspace ============"
catkin_make clean
catkin_make 


