#!/usr/bin/env bash

# Login with aws credential
echo "Creating pem file"
aws ec2 create-key-pair --key-name devops-dummy > devops-dummy.pem
chmod 600 devops-dummy.pem

echo "Launching Stack"
aws cloudformation create-stack --stack-name devops-dummy --template-body file://cloudformation.yaml \
--parameters ParameterKey=NumberOfInstances,ParameterValue=$1 \
ParameterKey=DummyInstanceType,ParameterValue=$2


# ./ec2.sh 5 t2.micro
