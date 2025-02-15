module "vpc" {
  source = "git::git@github.com:Gtsaas123/terraform-aws-vpc.git"

  name = "gtcaas-vpc-tf"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
  }
}
