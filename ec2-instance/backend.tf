# Adding backend as S3 for remote statefile
terraform {
  backend "s3" {
    bucket         = "prod-server-tf-state"
    dynamodb_table = "prod-server-tf-state-lock"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
  }
}
