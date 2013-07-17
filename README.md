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


6. Creating jenkins jobs
-------------

+ Open a terminal  and login as the jenkins user

		sudo su jenkins


+ Clone the "jenkins_config" repository
                
        cd
	    git clone https://github.com/ros-industrial/jenkins_config.git jenkins_config


+ Change mode for all the files in the "jenkins_config" repository

		chmod a+rwx -R jenkins_config


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
