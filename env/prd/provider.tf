terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "toy-terraform-tfstate"
    key            = "tfstate/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "TerraformStateLock"
    #profile = "default"
  }
}

provider "aws" {
  access_key = var.aws_access_key #git action에서는 생략
  secret_key = var.aws_secret_key #git action에서는 생략
  region     = var.aws_region
}

#resource "aws_dynamodb_table" "terraform_state_lock" {
#  name         = "TerraformStateLock"
#  hash_key     = "LockID"
#  billing_mode = "PAY_PER_REQUEST"
#
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#}