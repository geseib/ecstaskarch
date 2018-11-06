#! /bin/bash
AWS_ACCOUNT=$(aws sts get-caller-identity --output text | cut  -f1)
AWS_REGION="us-east-1"

APP_TASKNAME="tom-proxy3"
APP_PROXY="tom-proxy:latest"
APP_APP="tom-app:latest"
APP_LOGGER="tom-logger"

cat <<EOF
{
    "containerDefinitions": [{
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/tomproxy",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                }
            },
            "portMappings": [{
                "hostPort": 0,
                "protocol": "tcp",
                "containerPort": 80
            }],
            "cpu": 256,
            "memory": 256,
            "image": "$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$APP_PROXY",
            "essential": true,
            "links": [
                "app"
            ],
            "name": "nginx"
        },
        {
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/tomproxy",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                }
            },
            "cpu": 256,
            "mountPoints": [{
                "containerPath": "/usr/local/tomcat/logs",
                "sourceVolume": "logs"
            }],
            "memory": 512,
            "image": "$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$APP_APP",
            "essential": true,
            "name": "app"
        },
        {
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/tomproxy",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                }
            },
            "portMappings": [],
            "command": [
                "/var/log/localhost_access_log.*.txt"
            ],
            "mountPoints": [{
                "containerPath": "/var/log",
                "sourceVolume": "logs"
            }],
            "memory": 128,
            "image": "$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$APP_LOGGER",
            "essential": true,
            "name": "accesslog"
        },
        {
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/tomproxy",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                }
            },
            "command": [
                "/var/log/catalina.*.log"
            ],
            "mountPoints": [{
                "containerPath": "/var/log",
                "sourceVolume": "logs"
            }],
            "memory": 128,
            "image": "$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$APP_LOGGER",

            "name": "catalinalog"
        }
    ],
    "taskRoleArn": "arn:aws:iam::511976418858:role/catsndogs0-catsContainerTaskRole-DTS38WBBWEZ1",
    "family": "$APP_TASKNAME",
    "networkMode": "bridge",
    "volumes": [{
        "name": "logs"
    }]
}
EOF
