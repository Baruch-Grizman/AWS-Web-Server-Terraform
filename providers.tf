# Terraform cloud integration
terraform {
  cloud {
    organization = "Dev-Projects"

    workspaces {
      name = "AWS-Web-Server-Terraform"
    }
  }
}

# Setting up the AWS Provider with Terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = us-east-1
}