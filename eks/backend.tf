terraform {
  backend "s3" {
    bucket         = "terraform-state-gtsaas"
    key            = "state/1.0/vpc-gtsaas.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state_lock"
    encrypt        = true
  }
}