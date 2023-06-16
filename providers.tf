terraform {
  required_providers {
    aws = {
      version               = "~> 5.0.0"
      source                = "hashicorp/aws"
      configuration_aliases = [aws.deploy]
    }
  }
}

data "aws_caller_identity" "deploy" {
  provider = aws.deploy
}

locals {
  aws_account_id_deploy = data.aws_caller_identity.deploy.account_id
}
