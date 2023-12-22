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
  subnet_ids = [for subnet_id in var.node_subnet_ids : subnet_id]
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

  # eks configmap aws-auth에 콘솔 사용자 혹은 역할 등록
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
      userarn  = "arn:aws:iam::902643419733:user/dhlee"
      username = "dhlee"
      groups   = ["system:masters"]
    }
  ]
  enable_irsa = true
  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }
}
#aws-auth
data "aws_eks_cluster" "default" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
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

