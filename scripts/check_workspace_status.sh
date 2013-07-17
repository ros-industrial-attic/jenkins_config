#!/bin/bash

# variables
JENKINS_HOME=/var/lib/jenkins
SCRIPTS_PATH=${JENKINS_HOME}/jenkins_config/scripts
CATKIN_WORKSPACE=$1
JOB_NAME=$2
JOB_WORKSPACE_FILE=${JENKINS_HOME}/jenkins_config/workspaces/${JOB_NAME}.rosinstall
CATKIN_SETUP_FILE=${CATKIN_WORKSPACE}/devel/setup.bash

# check if setup file for catkin workspace exists
if [ -f $CATKIN_SETUP_FILE ];
then

	cd $1
	repo_list=`rosws info --only=path,scmtype,version`
	for line in $repo_list; do

	  repo=(${line//,/ })
	  path=${repo[0]} # branch
	BRANCH_NAME=$1
	  type=${repo[1]}
	  version=${repo[2]}
	  
	  if [ $type ]; then

	    # git repository	
	    if [ $type == "git" ]; then
	      cd $path
	      if [ -z $version ]; then
		version="HEAD"
	      fi
	      git fetch &>/dev/null
	      behind=`git rev-list ${version}...origin/${version} --count`
	      
	      if [[ $behind -ne 0 ]]; then
		echo behind
		exit 0
	      fi

            # svn repository
	    elif [ $type == "svn" ]; then     
	      if [ -z $version ]; then
		cd $path
		behind=`svn diff -r HEAD`
		
		if [ ! -z "$behind" ]; then
		  echo behind
		  exit 0
		fi
	      fi
	    fi
		
	  fi

	done

else
	${SCRIPTS_PATH}/create_catkin_workspace.sh ${CATKIN_WORKSPACE} ${JOB_WORKSPACE_FILE}
	echo behind
	exit 0
fi



echo synced
exit 0
