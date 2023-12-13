module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  #create_kms_key = false

  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  create_cluster_security_group = false
  cluster_security_group_id     = aws_security_group.cluster_security_group.id

  create_node_security_group = false
  node_security_group_id     = aws_security_group.node_security_group.id

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id = var.vpc_id
  # vpc_name                 = var.vpc_name
  subnet_ids = [for subnet_id in var.node_subnet_ids : subnet_id]
  #control_plane_subnet_ids = [for subnet_id in aws_subnet.node_subnet : subnet_id.id]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types             = [var.node_instance_type]
    iam_role_attach_cni_policy = true
  }

  eks_managed_node_groups = {
    node_group = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = [var.node_instance_type]
      block_device_mappings = {
        device_name = "dev/xvda"
        ebs = {
          volume_size = 10
          encrypted   = true
        }
      }
      #iam_role_attach_cni_policy = true
      tags = {
        Name = "eks-node"
      }
    }
  }

  # Fargate Profile(s)
  # fargate_profiles = {
  #   default = {
  #     name = "default"
  #     selectors = [
  #       {
  #         namespace = "default"
  #       }
  #     ]
  #   }
  # }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  #   aws_auth_roles = [
  #     {
  #       rolearn  = "arn:aws:iam::66666666666:role/role1"
  #       username = "role1"
  #       groups   = ["system:masters"]
  #     },
  #   ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::902643419733:user/mor1"
      username = "mor1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::902643419733:user/mor2"
      username = "mor2"
      groups   = ["system:masters"]
    },
  ]

  #   aws_auth_accounts = [
  #     "777777777777",
  #     "888888888888",
  #   ]

  #   tags = {
  #     Environment = "dev"
  #     Terraform   = "true"
  #   }
  # }
}


#보안그룹 생성 코드
resource "aws_security_group" "node_security_group" {
  name        = "eks-node-sg"
  description = "Security group for eks-node"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "cluster_security_group" {
  name        = "eks-cluster-sg"
  description = "Security group for-eks-cluster"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "cluster_sg_rules_cidr" {
  for_each = var.cluster_sg_rules_cidr

  type      = each.value.type
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  security_group_id = aws_security_group.cluster_security_group.id


  cidr_blocks = [each.value.cidr_blocks]
}

resource "aws_security_group_rule" "cluster_sg_rules_sg" {
  for_each = var.cluster_sg_rules_sg

  type      = each.value.type
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  security_group_id = aws_security_group.node_security_group.id


  source_security_group_id = aws_security_group.node_security_group.id

}


resource "aws_security_group_rule" "node_sg_rules_cidr" {
  for_each = var.node_sg_rules_cidr

  type      = each.value.type
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  security_group_id = aws_security_group.node_security_group.id


  cidr_blocks = [each.value.cidr_blocks]
}

resource "aws_security_group_rule" "node_sg_rules_sg" {
  for_each = var.node_sg_rules_sg


  type      = each.value.type
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  security_group_id = aws_security_group.node_security_group.id


  source_security_group_id = aws_security_group.cluster_security_group.id

}