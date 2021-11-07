#!/bin/sh 

ecr_repo="flask-docker-twingate"
aws_account_id=$(aws sts get-caller-identity --query Account --output text)
region=$(aws configure get region)
# login and create ecr repository 
$(aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${region}.amazonaws.com)
$(aws ecr create-repository --repository-name ${ecr_repo} --image-scanning-configuration scanOnPush=true --region ${region}
