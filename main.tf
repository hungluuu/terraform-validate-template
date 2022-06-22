terraform {
  backend "s3" {
    bucket  = "terraform-remote-state-20220621" #update based on the bucket created from bootstrap
    key     = "terraform-validate-pipeline.tfstate"
    region  = "eu-central-1"
    encrypt = "true"
  }
}

locals {
  aws_region = "eu-central-1"
  prefix     = "${var.repository_name}-${var.listen_branch_name}-pipeline"
  ssm_prefix = "/org/terraform"
  common_tags = {
    Project   = local.prefix
    ManagedBy = "Terraform"
  }
}

