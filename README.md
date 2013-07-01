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


6. Exporting a jenkins job
-------------

+ Open a terminal  and login as the jenkins user

		sudo su jenkins


+ Find/Print the jenkins home directory

		cd && pwd


+ Copy an entire folder from the "jobs" directory in the repo into the "jobs" directory in the jenkins home

		sudo cp [repo path]/jobs/ros_industrial_groovy_git [jenkins home path]/jobs


+ Modify job directory access mode (Don't run the following as the jenkins user)

		sudo chmod a+rwx -R [jenkins home path]/jobs


+ In the jenkins browser, go to jenkins home and then:
	+ Manage Jenkins -> Reload Configuration from Disk

+ Return to the jenkins home and you should see your job listed on the right hand side of the page.

See: https://wiki.jenkins-ci.org/display/JENKINS/Administering+Jenkins#AdministeringJenkins-Moving/copying/renamingjobs



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
