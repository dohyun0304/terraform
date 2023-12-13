variable "cluster_name" {
  description = "Name tag for the eks"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}

# variable "vpc_name" {
#   description = "Name tag for the VPC"
#   type        = string
# }

variable "cluster_endpoint_public_access_cidrs" {
  default = ["0.0.0.0/0"]
}
variable "node_subnet_ids" {
  description = "The ID of the VPC where resources will be created"
  type        = list(any)
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
