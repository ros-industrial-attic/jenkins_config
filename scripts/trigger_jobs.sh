#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH

# variables
JENKINS_HOME=/var/lib/jenkins
SCRIPTS_PATH=${JENKINS_HOME}/jenkins_config/scripts
JENKINS_CLI=${JENKINS_HOME}/jenkins-cli.jar
export JENKINS_CMD="java -jar "${JENKINS_CLI}" -s http://localhost:8080"

echo "updating jenkins_config repository"
cd ${JENKINS_HOME}/jenkins_config && git pull #&>/dev/null

if [ ! -f $JENKINS_CLI ];
then
	echo "downloading jenkins-cli.jar"
	cd ${JENKINS_HOME}
	wget http://localhost:8080/jnlpJars/jenkins-cli.jar
	chmod a+rwx ${JENKINS_CLI}
fi

# install required jenkins plugins
${SCRIPTS_PATH}/install_plugins.sh


# creating jobs
for F in ${JENKINS_HOME}/jenkins_config/workspaces/*; do
	
	if [ "${F##*~}" == "" ];
	then
		echo "temporary file found: $F, skipping"
		continue
	fi

	file_name=${F##*/}
	job_name=${F%.rosinstall}
	job_name=${job_name##*/}
	echo "found job $job_name with file $file_name"
	${SCRIPTS_PATH}/create_jenkins_job.sh $job_name
done


# checking jobs
for D in ${JENKINS_HOME}/jobs/*; do

	echo "job found in directory $D"
	  crumbs=(${D//\// })                                                 
	  job=${crumbs[${#crumbs[@]} - 1]}
	  status=`$SCRIPTS_PATH/check_workspace_status.sh $D/workspace $job`
	  if [ $status == "behind" ];
	  then

	    echo Triggering $job
	    #wget http://localhost:8080/job/$job/build?delay=0sec #&>/dev/null
	    java -jar ${JENKINS_CLI} -s http://localhost:8080 build $job

	  else
	    echo $job already up to date.
	  fi
done

