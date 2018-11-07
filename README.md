ecstaskarch
sidecar reference architeture for Tomcat application using Amaazon ECS taskdefinition

## Sidecars ##
by moving processes out of the main application container, but tightly coupled, we create a more stable, secure environment fot the application. it also simplifies support. of course automatic sidecar injection will take this a step further. But baby steps...

## Parts ##
1. the main application is a sample tomcat web app, nothing special
2. Nginx is the reverese proxy and is the only network way into the application.
3. logger containers are addeded as needed to create seperate logs streams. Ideal if the format of various logs are drastically different. 


**Create Repos**
the shell script createrepos.sh should be edited with the names you want to use in Amazon ECR. It will then create repos for the sample app, the Reverese Proxy, and the logging sidecar.

**Build images**
the shell script buildimages.sh should be edited with the names you used above. It will then build docker images for the sample app, the Reverese Proxy, and the logging sidecar. It then pushes them to the repos.

## Todo ##
1. streamline Env Variable section above
2. finish taskdefinition build automation script. the template has started and will create .json
3. create service automation
4. addin lets encrypt to push cert to nginx container.
5. move above tasks to codebuild
6. create codepipeline that pulls from codecommit, runs codebuild to build images and taskdefinition and final step update service
7. Blue green

