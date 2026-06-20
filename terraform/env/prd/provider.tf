terraform {
  required_version = ">=1.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.50"
    }
  }
}

# Provider
provider "aws" {
  profile = "default"
  region  = local.region
  default_tags {
    tags = {
      env     = local.env
      project = local.project
    }
  }
}
