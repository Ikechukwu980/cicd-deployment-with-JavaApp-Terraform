terraform {
  required_version = ">= 0.13.1"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }
}

provider "aws" {
  version = ">= 3.72"
  region  = 'us-west-2'
  profile = var.aws_profile
}