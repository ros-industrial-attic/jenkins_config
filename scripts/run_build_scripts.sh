#!/bin/bash

# the contents of this file should be copied in the execute shell box of the jenkins job

echo "Job name:    "$JOB_NAME
echo "Workspace:   "$WORKSPACE

#path to scripts directory
JOB_SCRIPTS_PATH=/var/lib/jenkins/jenkins_config/scripts

# initialize ROS and build catkin ws
source $JOB_SCRIPTS_PATH"/build_catkin_workspace.sh"

# Cpplint
source $JOB_SCRIPTS_PATH"/run_cpplint.bash" $WORKSPACE"/src"

# Counting lines of code/comments
source $JOB_SCRIPTS_PATH"/run_codecount.bash" $WORKSPACE"/src"

# CPP check
source $JOB_SCRIPTS_PATH"/run_cppcheck.bash" $WORKSPACE"/src"

# Coverage
#source $WORKSPACE"/../scripts/run_gcorv.bash" $WORKSPACE"/src"

