terraform {
  backend "s3" {
    bucket         = "00007www.myreactcicd.com"
    key            = "terraform/state.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}
