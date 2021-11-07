## project for deploying Flask apps into AWS

### 0. Contents
- `app/`
  - contains a Python Flask application, which is hooked up to DynamoDB
- `terraform/`
  - contains the terraform code necessary to deploy the application into AWS
  
### 1. Prereqs
- docker
- terraform
- aws account with aws-cli installed and configured

### 2. How-to
general workflow: 
1. work and build the docker image
2. tag the docker image with the environment variable(see example below)
3. push the image to ecr repository(see example below)
4. run terraform init & plan, then apply
5. terraform will output the alb url at the end of the run

## 3. Steps
- Download and extract this repo


(docker)
- run this command in terminal:

export AWS_ID=$(aws sts get-caller-identity --query Account --output text) && export AWS_REGION=$(aws configure get region &&--output text) && export AWS_ECR=flask-docker-twingate

- run the shell script: setup.sh (this will connect and login to aws ecr)  
- from the app folder, run docker build
- tag the image:
docker tag $AWS_ECR:latest $AWS_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$AWS_ECR:latest
- push the image to ecr repository:
docker push $AWS_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$AWS_ECR:latest


(terraform)
- once the image was uploded to ecr, enter the terraform directory and create a file "credentials", insert:

[default]
aws_access_key_id=<access_key>
aws_secret_access_key=<secret_access_key>
region=us-west-2
output=json

- set the access key & secret access key to the credentials file

- run:
terraform init
- after we initialized the working directory, run the plan:
terraform plan
- if the plan is without any errors, we can apply to create the stack
terraform apply

- after the run, terraform will output the alb url, use it.


docker build
