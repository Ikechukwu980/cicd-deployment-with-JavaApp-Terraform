terraform {
  required_version = ">= 0.13.1"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
     # version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
     # version = ">= 2.10"
    }
  }
}

provider "aws" {
#  version = ">= 3.72"
  region  = var.aws_region
}

data "aws_availability_zones" "available" {}

# Not required: currently used in conjunction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}

