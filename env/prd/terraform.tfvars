aws_access_key = ""
aws_secret_key = ""
aws_region     = "ap-northeast-2"
#
#####################VPC#####################
vpc_cidr = "10.0.0.0/16"
vpc_name = "Project VPC"

public_subnets = {
  subnet1 = { cidr = "10.0.101.0/24", az = "ap-northeast-2a" }
  #"subnet2= {cidr = "10.0.102.0/24", az = "ap-northeast-2b"}
  #"subnet3= {cidr = "10.0.103.0/24", az = "ap-northeast-2c"}
}

private_subnets = {
  subnet1 = { cidr = "10.0.201.0/24", az = "ap-northeast-2a" }
  #  "subnet2={cidr= "10.0.202.0/24", az= "ap-northeast-2b"},
  #  "subnet3={cidr= "10.0.203.0/24", az= "ap-northeast-2c"}
}

node_subnets = {
  subnet1 = { cidr = "10.0.10.0/24", az = "ap-northeast-2a" }
  subnet2 = { cidr = "10.0.20.0/24", az = "ap-northeast-2c" }
  #  "subnet3={cidr= "10.0.103.0/24", az= "ap-northeast-2c"}
}

enable_nat_gateway = true
enable_vpn_gateway = true

public_route_cidrs = {
  subnet1 = ["0.0.0.0/0"]
  # subnet2=["0.0.0.0/0","34.10.0.1/32"]
}

node_route_cidrs = "0.0.0.0/0"

public_instance_sg_rule = {
  instance1 = [
    {
      type        = "egress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

private_instance_sg_rule = {
  instance1 = [
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 2002
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


#####################EC2#####################
public_instance_count  = 1
private_instance_count = 1

public_ami_id  = "ami-0c9c942bd7bf113a2"
private_ami_id = "ami-0c9c942bd7bf113a2"

public_instance_type  = "t2.micro"
private_instance_type = "t2.micro"

public_name  = "public-instance"
private_name = "private-instance"

environment = "prod"

#####################EKS#####################
cluster_name = "eks"

node_instance_type = "t3.small"

cluster_sg_rules_cidr = {
  rule1 = {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },

  rule2 = {
    type        = "egress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
}

cluster_sg_rules_sg = {
  rule1 = {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = null
  },

  rule2 = {
    type        = "egress"
    from_port   = "10250"
    to_port     = "10250"
    protocol    = "tcp"
    cidr_blocks = null
  }
}

node_sg_rules_cidr = {
  rule1 = {
    type        = "egress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },

  rule2 = {
    type        = "egress"
    from_port   = "10250"
    to_port     = "10250"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
}

node_sg_rules_sg = {
  rule1 = {
    type        = "ingress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = null
  },

  rule2 = {
    type        = "ingress"
    from_port   = "10250"
    to_port     = "10250"
    protocol    = "tcp"
    cidr_blocks = null

  }
}

#####################RDS#####################
rds_name              = "chiking-rds"
rds_instance_class    = "db.t3.micro"
rds_allocated_storage = "20"
rds_engine            = "mysql"
engine_version        = "8.0.33"
rds_username          = "test"
rds_password          = "bespin135!!"
rds_db_name           = "collect"
rds_subnet_a_cidr     = "10.0.102.0/24"
rds_subnet_b_cidr     = "10.0.103.0/24"
rds_az_a              = "ap-northeast-2a"
rds_az_b              = "ap-northeast-2b"


rds_sg_rules_cidr = {
  rule1 = {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "10.0.10.0/24"
  },
  rule2 = {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
    },
  rule3 = {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "10.0.20.0/24"
  }
}