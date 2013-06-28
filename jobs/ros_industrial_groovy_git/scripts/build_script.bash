#!/bin/bash
echo "Job name:    "$JOB_NAME
echo "Workspace:   "$WORKSPACE

#path to scripts directory
JOB_SCRIPTS_PATH=${JENKINS_HOME}/jobs/${JOB_NAME}/scripts

# initialize ROS and build catkin ws
source $JOB_SCRIPTS_PATH"/run_workspace_setup.bash"

# Cpplint
source $JOB_SCRIPTS_PATH"/run_cpplint.bash" $WORKSPACE"/src"

# Counting lines of code/comments
source $JOB_SCRIPTS_PATH"/scripts/run_codecount.bash" $WORKSPACE"/src"

# CPP check
source $JOB_SCRIPTS_PATH"/run_cppcheck.bash" $WORKSPACE"/src"

# Coverage
#source $WORKSPACE"/../scripts/run_gcorv.bash" $WORKSPACE"/src"

