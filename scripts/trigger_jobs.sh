#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH

# variables
JENKINS_HOME=/var/lib/jenkins
SCRIPTS_PATH=${JENKINS_HOME}/jenkins_config/scripts

echo Running trigger jenkins cron job ...
cd ${JENKINS_HOME}/jenkins_config && git pull &>/dev/null

for D in /var/lib/jenkins/jobs/*; do

echo "job found in directory $D"
  crumbs=(${D//\// })                                                 
  job=${crumbs[${#crumbs[@]} - 1]}
  status=`/var/lib/jenkins/jenkins_config/scripts/check_workspace_status.sh $D/workspace $job`
  if [ $status == "behind" ];
  then
    echo Triggering $job
    chmod a+rwx -R $D/workspace
    wget http://localhost:8080/job/$job/build?delay=0sec #&>/dev/null
  else
    echo $job already up to date.
  fi
done

