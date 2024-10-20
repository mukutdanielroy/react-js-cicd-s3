# S3 bucket for storing builds with versioning enabled
resource "aws_s3_bucket" "react_build_artifacts" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "React Build Artifacts Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.react_build_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "react_website_config" {
  bucket = aws_s3_bucket.react_build_artifacts.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.react_build_artifacts.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.react_build_artifacts.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.react_build_artifacts.id
  acl = "public-read"

  depends_on = [ aws_s3_bucket_ownership_controls.bucket_ownership, aws_s3_bucket_public_access_block.bucket_public_access ]
}

# DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Locks"
    Environment = var.dynamodb_table_name
  }
}
