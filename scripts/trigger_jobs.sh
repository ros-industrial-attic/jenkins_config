#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH

# variables
JENKINS_HOME=/var/lib/jenkins
SCRIPTS_PATH=${JENKINS_HOME}/jenkins_config/scripts

echo Running trigger jenkins cron job ...
cd ${JENKINS_HOME}/jenkins_config && git pull &>/dev/null

# creating jobs
for F in ${JENKINS_HOME}/jenkins_config/workspaces/*; do
	
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
	    chmod a+rwx -R $D/workspace
	    #wget http://localhost:8080/job/$job/build?delay=0sec #&>/dev/null
	    java -jar jenkins-cli.jar -s http://localhost:8080 build $job
	  else
	    echo $job already up to date.
	  fi
done

