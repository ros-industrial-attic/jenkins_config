#!/bin/bash
# CPP Check
echo "===== Performing CPP check ====="

if [ -f ${WORKSPACE}/cppcheck.xml ];
then
	echo "removing old cppcheck.xml file"
	rm ${WORKSPACE}/cppcheck.xml
else
	echo "cppcheck.xml file not found, skipping deletion"
fi

for ROS_PATH in $@;
do
	cppcheck --enable=all -q --xml $ROS_PATH &>> ${WORKSPACE}/cppcheck.xml

done

#removing extra xml identifiers
sed -e '2,${/^<?xml/d}' -i ${WORKSPACE}/cppcheck.xml
sed -e '$ ! {/^<\/result/d}' -i ${WORKSPACE}/cppcheck.xml
sed -e '3,${/^<result/d}'  -i ${WORKSPACE}/cppcheck.xml

echo "===== Completed CPP check ====="
