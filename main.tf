terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.61"
    }
  }
  /*
  backend "remote" {
    organization = "the-amit"

    workspaces {
      name = "my-app-prod"
    }
  }
  */
  required_version = ">= 0.15.4"

}

provider "aws" {
  profile = "default"
  region  = "ca-central-1"
}

resource "random_pet" "petname" {
  length    = 5
  separator = "-"

  provisioner "local-exec" {
    command = "echo ${random_pet.petname.id} >> petname.txt"
  }
}

module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "${random_pet.petname.id}-${formatdate("DD-MM-YY", timestamp())}" #update this with variable condition

  tags = {
    Terraform   = var.vpc_tags["Terraform"]
    Environment = "${terraform.workspace}"
  }

  # Creating explicit dependencies on ec2 instances
  depends_on = [module.ec2_instances]
}
