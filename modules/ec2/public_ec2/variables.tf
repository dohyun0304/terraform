variable "instance_count" {
  description = "Number of instances to create"
}

variable "ami_id" {
  description = "ID of the AMI to use for the instance"
}

variable "instance_type" {
  description = "Type of instance"
}

variable "subnet_id" {
  description = "ID of the subnet where the instances will be created"
  type        = string
}

variable "name" {
  description = "Name tag for resources"
}

variable "environment" {
  description = "Environment tag for resources"
}

variable "public_instance_eip_ids" {
  description = "List of IDs of Elastic IPs for public instances"
  type        = list(string)
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


variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}