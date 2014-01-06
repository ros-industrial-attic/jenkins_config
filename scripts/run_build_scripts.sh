#!/bin/bash
echo "Job name:    "$JOB_NAME
echo "Workspace:   "$WORKSPACE

#path to scripts directory
JOB_SCRIPTS_PATH=/var/lib/jenkins/jenkins_config/scripts

# update catkin ws
$JOB_SCRIPTS_PATH"/update_catkin_workspace.sh"

# Cpplint
$JOB_SCRIPTS_PATH"/run_cpplint.bash" $WORKSPACE"/src"

# Counting lines of code/comments
$JOB_SCRIPTS_PATH"/run_codecount.bash" $WORKSPACE"/src"

# CPP check
$JOB_SCRIPTS_PATH"/run_cppcheck.bash" $WORKSPACE"/src"

# Coverage
source $WORKSPACE"/../scripts/run_gcorv.bash" $WORKSPACE"/src"

# build catkin ws
$JOB_SCRIPTS_PATH"/clean_catkin_workspace.sh"

# build catkin ws
$JOB_SCRIPTS_PATH"/build_catkin_workspace.sh"

