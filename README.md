ecstaskarch
sidecar reference architeture for Tomcat application using Amaazon ECS taskdefinition


**Create Repos**
the shell script createrepos.sh should be edited with the names you want to use in Amazon ECR. It will then create repos for the sample app, the Reverese Proxy, and the logging sidecar.

**Build images**
the shell script buildimages.sh should be edited with the names you used above. It will then build docker images for the sample app, the Reverese Proxy, and the logging sidecar. It then pushes them to the repos.

