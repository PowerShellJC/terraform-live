provider "aws" {
  region = "ap-southeast-2"
}
resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  password            = "password"
  skip_final_snapshot  = true
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "jc-testing-terraform-up-and-running-state"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "ap-southeast-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "jc-testing-terraform-up-and-running-locks"
    encrypt        = true
  }
}