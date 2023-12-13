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

variable "vpc_id" {
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

