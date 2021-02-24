data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = "jc-testing-terraform-up-and-running-state"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "jc-testing-terraform-up-and-running-state"
    key            = "prod/services/webserver-cluster/terraform.tfstate"
    region         = "ap-southeast-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "jc-testing-terraform-up-and-running-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

module "webserver_cluster" {
  source = "github.com/PowerShellJC/Terraform-Test?ref=v0.0.1"
  cluster_name = "webservers-prod"
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10
}