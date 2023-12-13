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