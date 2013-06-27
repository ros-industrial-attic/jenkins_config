jenkins_config
==============
Contains jenkins CI configuration scripts.
============================
Restarting jenkins from a terminal
	
	- Open a terminal and enter
		/etc/init.d/jenkins

============================
Access jenkins from a browser
	
	- Open a browser and enter "http://localhost:8080/" in the address bar

============================
Exporting a jenkins job

	- Copy an entire folder from the "jobs" directory in the repo into the "jobs" directory that lives in your machine's jenkins home directory.
	- Access jenkins from a browser by entering "http://localhost:8080/" in the address bar
	- In the jenkins browser, go to jenkins home and then:
		Manage Jenkins -> Reload Configuration from Disk
	- Return to the jenkins home and you should see your job listed on the right hand side of the page.

See: https://wiki.jenkins-ci.org/display/JENKINS/Administering+Jenkins#AdministeringJenkins-Moving/copying/renamingjobs

============================
Restore entire jenkins setup from a backup in the repo

	- Close any running instances of jenkins, including browsers and terminals 
	- Find jenkins home directory, from a terminal type the following to print the absolute path of the jenkins home:
		sudo su jenkins 
		cd 
		pwd
	- Copy all the contents of a jenkins home directory backup under the "jenkins_settings" in the repo into the jenkins home directory in your local machine.
	- Open jenkins from a browser
	- Copy jobs as needed


