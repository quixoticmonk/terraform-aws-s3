resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}


data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../../"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  tags = local.tags
}

module "glue" {
  source  = "quixoticmonk/glue/aws"
  version = "0.0.3"
  
  prefix = "minimal-"
  
  # IAM Role
  create_iam_role = true
  
  # Glue Job with S3 script
  create_job = true
  job_name   = "simple-job"
  job_type   = "glueetl"
  glue_version = "4.0"
  
  # Use existing S3 bucket and script
  create_s3_bucket = false
  existing_s3_bucket_name = "statetest-s3"
  job_script_local_path = "${path.module}/scripts/simple_job.py"
  
  # Worker configuration
  worker_type = "G.1X"
  number_of_workers = 2
  
  tags = {
    Environment = "dev"
  }
}
