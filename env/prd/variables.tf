#####################common#####################
variable "aws_access_key" { #git action에서는 생략
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" { #git action에서는 생략
  description = "AWS secret key"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "terraform" {
  description = "managed by terraform"
  type        = string
}

#####################VPC#####################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}


variable "private_subnets" {
  description = "Map of private subnets CIDR blocks for the VPC"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "public_subnets" {
  description = "Map of public subnets CIDR blocks for the VPC"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "node_subnets" {
  description = "Map of EKS Node subnets CIDR blocks for the VPC"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway in the VPC"
  type        = bool
}

variable "enable_vpn_gateway" {
  description = "Enable VPN gateway in the VPC"
  type        = bool
}

variable "public_route_cidrs" {
}

variable "node_route_cidrs" {
}

variable "public_instance_sg_rule" {
  description = "Security group rules"
  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })))
}

variable "private_instance_sg_rule" {
  description = "Security group rules"
  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })))
}



#####################EC2#####################
variable "public_instance_count" {
  description = "Number of public instances to create"
}

variable "private_instance_count" {
  description = "Number of private instances to create"
}

variable "public_ami_id" {
  description = "ID of the AMI to use for the public instance"
}

variable "private_ami_id" {
  description = "ID of the AMI to use for the private instance"
}

variable "public_instance_type" {
  description = "Type of public instance"
}

variable "private_instance_type" {
  description = "Type of private instance"
}

variable "public_name" {
  description = "Name tag for public resources"
}

variable "private_name" {
  description = "Name tag for private resources"
}
variable "environment" {
  description = "Environment tag for resources"
}


####################EKS
variable "cluster_name" {
  description = "Name tag for the eks"
  type        = string
}

variable "node_instance_type" {
  type = string
}
/*
variable "node_sg_rule" {
  description = "node Security group rules"

  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = any
  })))
}


variable "cluster_sg_rule" {
  description = "cluster Security group rules"

  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = any
  })))
}
*/
variable "cluster_sg_rules_cidr" {
  type = map(any)
}

variable "cluster_sg_rules_sg" {
  type = map(any)
}

variable "node_sg_rules_cidr" {
  type = map(any)
}

variable "node_sg_rules_sg" {
  type = map(any)
}

#####################RDS#####################

variable "rds_name" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_allocated_storage" {
  type = string
}

variable "rds_engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_db_name" {
  type = string
}

variable "rds_subnet_a_cidr" {
  type = string
}

variable "rds_subnet_b_cidr" {
  type = string
}

variable "rds_az_a" {
  type = string
}

variable "rds_az_b" {
  type = string
}
variable "rds_sg_rules_cidr" {
  type = map(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
  }))
}

