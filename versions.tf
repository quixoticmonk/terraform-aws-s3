terraform {
required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
        password="1234924password"
    }
  }
}
