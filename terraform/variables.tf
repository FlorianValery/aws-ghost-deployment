/*--------------------------------------------------------------------------------------------------
  Global 
--------------------------------------------------------------------------------------------------*/

variable "region" {
  description = "Region where the resources will be deployed"
  type        = string
  default     = "eu-west-3"
}

variable "tags" {
  description = "Global tags applied to every resource by default"
  default = {
    Terraform = "true"
    Project   = "ghost"
  }
}

/*--------------------------------------------------------------------------------------------------
  VPC
--------------------------------------------------------------------------------------------------*/

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "ghost_vpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]
}

variable "public_subnets" {
  description = "Public subnets where the ghost instances will be deployed"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "database_subnets" {
  description = "Private subvnets where the RDS instance will be deployed"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

/*--------------------------------------------------------------------------------------------------
  RDS
--------------------------------------------------------------------------------------------------*/

variable "mysql_engine_version" {
  description = "Versions available: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html"
  type        = string
  default     = "5.7"
}

variable "mysql_instance_class" {
  description = "MySQL instance class, only db.t2.micro is free tier eligible"
  type        = string
  default     = "db.t2.micro"
}

variable "mysql_name" {
  description = "MySQL database name"
  type        = string
  default     = "ghostdb"
}

variable "mysql_username" {
  description = "MySQL admin username"
  type        = string
  default     = "admin"
}

variable "mysql_password" {
  description = "MySQL password"
  type        = string
  default     = ""
}

variable "mysql_parameter_group_name" {
  description = "Mysql parameter group name"
  type        = string
  default     = "default.mysql5.7"
}

/*--------------------------------------------------------------------------------------------------
  EC2 / ASG
--------------------------------------------------------------------------------------------------*/

variable "ec2_instance_type" {
  description = "EC2 instance type used for Ghost, only t2 micro is free tier eligible"
  type        = string
  default     = "t2.micro"
}

variable "asg_max_size" {
  description = "ASG maximum instance count"
  type        = string
  default     = 1
}

variable "asg_min_size" {
  description = "ASG minumum instance count"
  type        = string
  default     = 1
}

/*--------------------------------------------------------------------------------------------------
  User data vars
--------------------------------------------------------------------------------------------------*/

variable "website_url" {
  description = "Your ghost website URL, has to match the origin (custom domain OR load balancer DNS Name)"
  type        = string
  default     = ""
}

variable "website_admin_url" {
  description = "Your ghost website admin URL, has to match the origin (custom domain OR load balancer DNS Name). Can be a subdomain of website_url"
  type        = string
  default     = ""
}