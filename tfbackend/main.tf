provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "eks-statefile-bucket-dev"

  tags = {
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "state_dynamodb" {
  name           = "tf-state-lock"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = "Dev"
  }
}