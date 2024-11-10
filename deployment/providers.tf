
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.0"
    }
  }
  backend "s3" {
    bucket = "<your-s3-bucket-name>"
    key    = "dev/terraform.tfstate"
    region = "<your-region>"
  }
}

provider "aws" {
  region  = var.region
}
