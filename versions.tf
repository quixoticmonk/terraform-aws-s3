terraform {
required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
        awscc = {
      source  = "hashicorp/awscc"
    }
  }
}


provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
        created="manu"
    }
  }
}

provider "awscc" {
  region = var.aws_region
}
