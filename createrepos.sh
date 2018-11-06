#! /bin/bash

aws ecr create-repository --repository-name tom-proxy
aws ecr create-repository --repository-name tom-app
aws ecr create-repository --repository-name tom-logger
