variable "aws_region" {
  description = "The AWS region to deploy the resources."
  type        = string
  default     = "ap-south-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store build artifacts."
  type        = string
  default     = "00007www.myreactcicd.com"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table to store Terraform state locks."
  type        = string
  default     = "terraform-lock-table"
}

variable "environment" {
  description = "React frontend public s3 bucket."
  type        = string
  default     = "prod"
}
