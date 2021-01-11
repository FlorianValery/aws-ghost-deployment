# AWS Ghost Terraform module

Terraform module which creates a single instance Ghost deployment on AWS.


## Usage

* Export your AWS credentials using the CLI or tools like Awsume
* Provide your remote state information in backend.tf -- feel free to remove s3 if you're not using it as you default backend
* Update all the default values in variables.tf to fit you need
* Go to the terraform folder and apply the code
```
cd terraform
terraform init
terraform apply
```