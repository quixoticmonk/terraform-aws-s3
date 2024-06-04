variable "aws_region" {
  type = string
  description = "AWS region to use"
  default = "us-east-1"
}

variable "owner" {
  type = string
  default = "manu"
  description = "owner of the resource"
}

variable "bucket_name" {
  type = string
  description = "Name of the bucket"
  default   ="test-1234-20240-manu"
}
