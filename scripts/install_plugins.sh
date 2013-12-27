#!/bin/bash

# variables
JENKINS_HOME=/var/lib/jenkins
SCRIPTS_PATH=${JENKINS_HOME}/jenkins_config/scripts
CONFIG_FILE_PATH=${JENKINS_HOME}/jenkins_config/jobs/template_job/config.xml
JENKINS_CLI=${JENKINS_HOME}/jenkins-cli.jar
PLUGIN_LIST_FILE=${SCRIPTS_PATH}/plugin_list.txt

# listing installed plugins
installed_plugin_list=$(java -jar ${JENKINS_CLI} -s http://localhost:8080 list-plugins)
plugin_list=$(cat $PLUGIN_LIST_FILE)
#echo "$plugin_list"

# changing delimiter
IFS=$'\n'

# starting counter
counter=0
for p1 in $plugin_list
do
	counter=$(($counter+1))
	#echo "checking plugin $p1"
	
	# searching plugin in list of installed plugins
	found=false
	for line in $installed_plugin_list
	do

		# Finding installed plugin
		IFS=$' '
		plugin_name=''
		for p2 in $line
		do
			plugin_name=$p2
			break
		done
		IFS=$'\n'

		# comparing plugin		
		if [ "$plugin_name" == "$p1" ]; then
			echo "Plugin $plugin_name already installed"
			found=true
			break
		fi
	done

	if [ $found == false ]; then		
		echo "Plugin $p1 missing, start installation"
		java -jar ${JENKINS_CLI} -s http://localhost:8080 install-plugin $p1	
	fi
	
done
