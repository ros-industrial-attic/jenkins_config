#!/bin/bash
# Cpplint

#path to scripts directory
#JOB_SCRIPTS_PATH=${JENKINS_HOME}/jobs/${JOB_NAME}/scripts

echo "===== Executing Cpplint ====="

for ROS_PATH in  "$@";
do

	echo -e "\tExamining path: "$ROS_PATH
	python ${JOB_SCRIPTS_PATH}/cpplint.py  `find $ROS_PATH -regex '.*\.\(cpp\|h\)' | grep -v /external/ | grep -v /test/ | grep -v /build/ | grep -v /msg_gen/ | grep -v /liboxts_rt/ | grep -v /cfg/cpp/ | grep -v /srv_gen/` 2> ${WORKSPACE}/cpplint_warnings_absolute.txt

	### Ignore new-line curly brace warnings.
	grep -v '{ should almost always be at the end of the previous line' ${WORKSPACE}/cpplint_warnings_absolute.txt > ${WORKSPACE}/cpplint_filter1.txt

	### Ignore new-line else warnings.
	grep -v 'An else should appear on the same line as the preceding }' ${WORKSPACE}/cpplint_filter1.txt > ${WORKSPACE}/cpplint_filter2.txt

	### Make all paths relative so jenkins can find them.
	sed 's/\/var\/lib\/jenkins\/jobs\/${JOB_NAME}\/workspace\///g' ${WORKSPACE}/cpplint_filter2.txt >> ${WORKSPACE}/cpplint.txt
	
done

# Make all paths relative so jenkins can find them.
echo -e "\tChanging Cpplint absolute paths to relative paths"
sed "s:"$WORKSPACE"/src:trunk:g" ${WORKSPACE}/cpplint.txt > ${WORKSPACE}/cpplint_warnings.txt

#clenup
rm ${WORKSPACE}/cpplint_warnings_absolute.txt
rm ${WORKSPACE}/cpplint_filter1.txt
rm ${WORKSPACE}/cpplint_filter2.txt
rm ${WORKSPACE}/cpplint.txt

echo "===== Completed Cpplint ====="

