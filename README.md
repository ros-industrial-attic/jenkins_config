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

+	Go to "http://pkg.jenkins-ci.org/debian-stable/" and download the "jenkins_1.509.2_all.deb" package to a local directory
+	Open a terminal and do the following:

		sudo dpkg -i /path/to/debian/jenkins_1.509.2_all.deb
		sudo apt-get install -f 
		
+	Note: This installation procedure is preferred for now since a required plugin (plot plugin) is incompatible with the latest 
version of jenkins (version 1.524 ).  When this issue is fixed then installing jenkins should be done as follows:

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
	+	Warnings plugin
	+	Static Code Analysis Plug-ins
	+	Plot Plugin
	+	Violations Plugin
	+	Cppcheck Plugin


5. Configure jenkins
-------------
+	From jenkins home page go to: 
	+	Manage Jenkins -> Configure System
+	Under "Home directory" hit the "Advanced..." button
+	Set the "Workspace Root Directory" as "${ITEM_ROOTDIR}/workspace"
+	Set the "Build Record Root Directory" as "${ITEM_ROOTDIR}/build"


6. Installing the "jenkins_config" repo
-------------

+ Open a terminal  and login as the jenkins user

		sudo su jenkins


+ Clone the "jenkins_config" repository
                
        cd
        git clone https://github.com/ros-industrial/jenkins_config.git jenkins_config

+ Change git configuration
	
        cd jenkins_config
        git config core.fileMode false


+ Switch to appropriate git branch (required for projects like ros-industrial that have a different workspace config than the default jenkins setup)

        git checkout <branch_name>


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

7. User Controls (Optional)
-------------
If access controls or other security are used on the jenkins server, then some care must be taken to ensure that the job scripts run correctly.  

Credentials are required in order to create jobs.  For a terminal session, credentials can be entered using the jenkins login command
cd
java -jar jenkins-cli.jar -s login --username <user> --password <pass>
. ./jenkins_config/scripts/trigger_jobs.sh

In most cases, credentials aren't required for the scripts to initiate a build


8. Email setup (Optional)
-------------

The automatically created jenkins jobs aren't configured to send emails after each build.  In order to have jenkins send email notifications after each build open jenkins from a browser and do the following:

+ Go to Manage Jenkins -> Configure System
+ In the "E-mail Notification" tab, populate each field with the following info:

>>SMTP server - smtp.gmail.com   
Default user e-mail suffix - @gmail.com   

>>Use SMTP Authentication - yes  
User Name - your.email  
Password - p******d  

>>Use SSL - yes  
SMTP Port -465  
Reply-To Address - noreply@gmail.com  
Charset - UTF-8

+ Hit "Save" or "Apply" in order to save changes.

+ In your jenkins job go to: Configure -> Add post build-action-> E-mail Notification

+ Populate the "Recipients" text box with the email addresses that you would like jenkins to send notifications to.  

>#####Note:  
The configuration above requires a vaild gmail account.  If a non gmail account is used then the SMTP server information needs to be changed accordingly.  Regardless of the SMTP, the job can send notifications to emails from any domain.


Creating new jenkins jobs
==============
+ In order to create a new jenkins job, a "my_new_job.rosinstall" file needs to be added to the "workpaces" directory of the repo.  The new job will be named the same as the file without the ".rosinstall" extension and must list each tracked repo as in the following example:

##### my_new_job.rosinstall:  
        - git: {local-name: src/great_repo, version: stable-branch, uri: 'https://github.com/my_repos/great_repo.git'}  
        - git: {local-name: src/really_cool_repo, version: awesome-branch, uri: 'https://github.com/my_repos/really_cool_repo.git'}  
        - git: {local-name: src/broken_repo, version: broken-branch, uri: 'https://github.com/my_repos/broken_repo.git'}  
        - git: {local-name: src/much_cooler_repo, version: awesome-branch, uri: 'https://github.com/my_repos/much_cooler_repo.git'}  

>#####Note:        
It is required that each repository gets saved in the "src" directory of the job's workspace, otherwise it will not be built.

+ The job will be created and added to jenkins the next time that the "trigger_build.sh" script runs.  


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
