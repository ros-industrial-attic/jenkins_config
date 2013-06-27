#!/bin/bash

# Creating gcno and gcda files if they do not exist (this caused problems for gcovr below
find ${WORKSPACE} -type f -name '*.gcno' -print | sed s/\.gcno$/\.gcda/ | xargs touch

# clear file
echo "" > ${WORKSPACE}/coverage.xml

for ROS_PATH in $@;
do

	echo "===== Performing gcovr conversion ====="
	# Executing gcovr to convert to a jenkins readable format
	${WORKSPACE}/scripts/gcovr -x -r $ROS_PATH -e '.*/CMakeFiles/.*' -e '.*/test/.*' -e '.*/cfg/.*' -e '.*/msg_gen/.*'  -e '.*/srv_gen/.*' -e '.*/analysis/.*' -e '.*/build/.*' >> ${WORKSPACE}/coverage.xml

done
