#! /bin/bash
#customize variables as needed
AWS_ACCOUNT=$(aws sts get-caller-identity --output text | cut  -f1)
AWS_REGION="us-east-1"

APP_PROXY="tom-proxy:latest"
APP_APP="tom-app:latest"
APP_LOGGER="tom-logger"


#login to ECR
$(aws ecr get-login --no-include-email)

#build proxy server
cd proxy
docker build -t $APP_PROXY .
docker tag $APP_PROXY $AWS_ACCOUNT".dkr.ecr."$AWS_REGION".amazonaws.com/$APP_PROXY"
docker push $AWS_ACCOUNT".dkr.ecr."$AWS_REGION".amazonaws.com/$APP_PROXY"

#build proxy server
cd ../tomcat
docker build -t $APP_APP .
docker tag $APP_APP $AWS_ACCOUNT".dkr.ecr."$AWS_REGION".amazonaws.com/$APP_APP"
docker push $AWS_ACCOUNT".dkr.ecr."$AWS_REGION".amazonaws.com/$APP_APP"

#build proxy server
cd ../logger
docker build -t $APP_LOGGER .
docker tag $APP_LOGGER $AWS_ACCOUNT".dkr.ecr."$AWS_REGION".amazonaws.com/$APP_LOGGER"
docker push $AWS_ACCOUNT".dkr.ecr."$AWS_REGION".amazonaws.com/$APP_LOGGER"

