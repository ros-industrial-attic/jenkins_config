#!/bin/bash

# clear file
echo "" > ${WORKSPACE}/cpp_code.count
echo "" > ${WORKSPACE}/cpp_comments.count

# Count lines of code
CODE_LINES=""

echo "===== Performing count of code/comments lines ====="
for ROS_PATH in $@;
do

	echo -e "\tExamining path: "$ROS_PATH

	# Get the number of C/C++ code lines and comments in the project.
	CODE_LINES=$CODE_LINES'\n-----\n'$ROS_PATH
	CODE_LINES=$CODE_LINES$'\n'$(cloc --exclude-lang=XML $ROS_PATH | grep "^C \|^C++\|^C/")

done

# printing results
echo "----------------------------------------------------------"
echo -e "Lines of code results\n$CODE_LINES"
echo "----------------------------------------------------------"

# saving results
echo "$CODE_LINES" | awk 'NF && NF-1 {s+=$NF} END {print "YVALUE="s}' > ${WORKSPACE}/cpp_code.count
echo "$CODE_LINES" | awk 'NF && NF-1 {s+=$(NF-1)} END {print "YVALUE="s}' > ${WORKSPACE}/cpp_comments.count


echo "===== Completed count of code/comments lines ====="


