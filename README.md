	Jenkins Configuration Instructions
==============
Instructions to configure jenkins for building ros industrial repos


Required packages
==============
-	ros-groovy
-	Moveit 
-	Moveit for pr2 binaries 

Installation steps
==============


1. Install jenkins
--------------
		sudo apt-get install jenkins

2. Install associated tools
-------------
		sudo apt-get install cppcheck
		sudo apt-get install cloc
		sudo apt-get install python-rosinstall

3. Access jenkins from a browser
-------------
	
-	Open a browser and enter "http://localhost:8080/" in the address bar


4. Install the following plugins
-------------
+	Go to the jenkins home page and then to the Manage Plugins link:
	+	Manage Jenkins -> Manage Plugins

+	Install the plugins listed below:
	+	GitHub Plugin
	+	Jenkins Multiple SCMs plugin
	+	Warnings plugin
	+	Static Code Analysis Plug-ins
	+	Plot Plugin
	+	Violations Plugin
	+	Cppcheck Plugin


5. Configure git plugin user credentials
-------------
+	From jenkins home page go to: 
	+	Manage Jenkins -> Configure System
+	In the "Global Config user.name Value" textbox in the "Git plugin" section enter "jenkins"
+	In the "Global Config user.email Value" textbox in the "Git plugin" section enter "jenkins@domain.com"
+	Hit the "Save" or "Apply" buttom at the end of the page.


6. Installing the "jenkins_config" repo
-------------

+ Open a terminal  and login as the jenkins user

		sudo su jenkins


+ Clone the "jenkins_config" repository
                
        cd
	    git clone https://github.com/ros-industrial/jenkins_config.git jenkins_config


+ Open the crontab file for editing

        crontab -e

  When asked to "Select and editor" enter "2" for nano.

+ Append the following lines to the cron file in order to run the trigger script every 5 minutes

        */5 * * * * /bin/bash /var/lib/jenkins/jenkins_config/scripts/trigger_jobs.sh > /var/lib/jenkins/cron_log.txt

  Save the cron file once the changes have been made.  From this point on, the "trigger_jobs.sh" script will check your jenkins jobs periodically and will trigger a build if any of their tracked repositories has changed.  
This script will also create any jobs listed in the "workspaces" repo directory that don't have a designated directory in the jenkins "jobs" folder.  If a build was issued, you can see its current progress in the browser.  In addition, the output produced will be saved to the file "cron__log.txt"

+ (Optional) Run the trigger script inmediately

  Instead of waiting for cron to run the script you can call it directly.  You must log in as the jenkins user and then run the following from the jenkins home:

        jenkins_config/scripts/trigger_jobs.sh

Jenkins tips
==============
Login as the jenkins user
-------------
		sudo su jenkins

Go to the jenkins home
-------------
		sudo su jenkins
		cd

Force a jenkins restart from a terminal
-------------
		sudo /etc/init.d/jenkins restart
