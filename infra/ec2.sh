#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Invalid number of parameters"
    exit
fi

echo "Creating pem file"
aws ec2 create-key-pair --key-name devops-dummy --query 'KeyMaterial' --output text > devops-dummy.pem
chmod 400 devops-dummy.pem

echo "Launching Stack"
aws cloudformation create-stack --stack-name devops-dummy --template-body file://cloudformation.yaml \
--parameters ParameterKey=NumberOfInstances,ParameterValue=$1 \
ParameterKey=DummyInstanceType,ParameterValue=$2


# ./ec2.sh 5 t2.micro
