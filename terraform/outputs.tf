output "s3_bucket_name" {
  description = "S3 bucket used to store build artifacts"
  value       = aws_s3_bucket.react_build_artifacts.bucket
}

output "dynamodb_table_name" {
  description = "DynamoDB table for Terraform state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "website_url" {
  value = "http://${aws_s3_bucket.react_build_artifacts.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}