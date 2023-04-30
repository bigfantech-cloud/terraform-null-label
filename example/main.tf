provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "bigfantech-cloud/network/aws"

  vpc_cidr     = "10.0.0.0/20"
  project_name = "abc"
  environment  = "dev"
  attributes   = ["test", "bucket"]
}

resource "aws_s3_bucket" "default" {
  bucket = module.this.id # ID will get "abc-dev-test-bucket"

  tags = merge(
    module.this.tags, # tags will get { Project_name = "abc", Environment = "dev", attributes = ["test", "bucket"] }
    {
      "Name" = "${module.this.id}"
    },
  )
}
