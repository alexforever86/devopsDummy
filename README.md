Devops Assignment
-----------------

1. Script to provision an EC2 instance to deploy this app
    - Set the environment variable MYRA__SENTRY_DSN with a sentry dsn obtained by signing up to https://sentry.io
    - Deployment details
        - OS: Ubuntu 16.04; use ami-6edd3078
        - Server: Nginx
        - python 2.7
    - Restrict port access; allow only http and any other ports for deployment
    - Script should take in the number of servers and the size as input and deploy on that many server
    - ec2.sh num_servers server_size
    - ex: ec2.sh 1 t2.micro

2. Ansible/Chef/Puppet or bash scripts to deploy subsequent code changes and config changes to the newly created servers

After running the first script, it should output the IP address of the new instances and we should be able to open the browser to that instance and see output

In developing the assignment, use git and try to keep a decent history of how you approached the project. When submitting, include the .git folder in the submission.

Notes:
    - Assume that there are no security groups or key paris setup in the AWS account
    - Your script will have to setup those as well
    - No need to setup VPC, just launch EC2 instances without that
    
    
# Steps

## Provisioning

* Export the AWS Credentials

* From `infra` directory, run `ec2.sh`

```
./ec2.sh <instance_count> <instance_type>
```

Eg: `./ec2.sh 5 t2.micro`

## Deployment 

From `ansible` directory, run `deploy.sh`

```
./deploy.sh <ASG_name> <pem_filepath>
```

Eg: `./deploy.sh devops_dummy /path/to/pem`

Note: You can get the ASG name from the CloudFormation output or AWS Console

