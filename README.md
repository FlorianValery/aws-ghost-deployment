# AWS Ghost Terraform module

Terraform module which creates a single instance Ghost deployment on AWS.

## Overview 

Ghost is a free and open source blogging platform written in JavaScript and distributed under the MIT License, designed to simplify the process of online publishing for individual bloggers as well as online publications.

More information at [ghost.org](https://ghost.org/).

This module will allow you to deploy a single instance behind an Auto Scaling group and RDS using Terraform for high availability and ease of management. It is free tier eligible if you use the right instance sizes.

![Diagram](https://lebureau.dev/content/images/2021/01/image-27.png)

# Requirements

* An AWS account already setup
* A S3 bucket already defined for the Terraform state
* Terraform v0.14.x installed

## Usage

* Export your AWS credentials using the CLI or tools like Awsume
* Provide your remote state information in backend.tf -- feel free to remove s3 if you're not using it as you default backend
* Update all the default values in variables.tf 
* Go to the terraform folder and apply the code
```
cd terraform
terraform init
terraform apply
```


This repo is used as the source code for [this](https://lebureau.dev/deploying-ghost-3-0-to-aws-using-ec2-auto-scaling-rds-and-terraform-pt-1/) complete tutorial
