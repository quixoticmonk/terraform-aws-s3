mock_provider "aws" {
  alias = "mock_aws"
  mock_resource "aws_s3_bucket" {
    defaults = {
      arn = "arn:s3"
      id  = "bucket_name"
    }
  }
}

variables {
  bucket_name = "test_bucket_manu_chandrasekhar"
}

run "validate_plan" {

  command = plan

  providers = {
    aws = aws.mock_aws
  }

  assert {
    condition     = aws_s3_bucket.this.bucket == "test_bucket_manu_chandrasekhar"
    error_message = "S3 bucket name did not match expected"
  }


}

run "validate_bucket_output" {

  command = apply

  providers = {
    aws = aws.mock_aws
  }

  assert {
    condition     = aws_s3_bucket.this.id == "bucket_name"
    error_message = "S3 bucket name did not match expected"
  }

}