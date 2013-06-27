#!/bin/bash
echo "Job name:    "$JOB_NAME
echo "Workspace:   "$WORKSPACE

# initialize ROS and build catkin ws
source $WORKSPACE"/../scripts/run_workspace_setup.bash"

# Cpplint
source $WORKSPACE"/../scripts/run_cpplint.bash" $WORKSPACE"/src"

# Counting lines of code/comments
source $WORKSPACE"/../scripts/run_codecount.bash" $WORKSPACE"/src"

# CPP check
source $WORKSPACE"/../scripts/run_cppcheck.bash" $WORKSPACE"/src"

# Coverage
#source $WORKSPACE"/../scripts/run_gcorv.bash" $WORKSPACE"/src"

