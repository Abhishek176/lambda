terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
   region = var.region
}

# terraform {
#   backend "s3" {
#     bucket = "dtcc-tf"
#     key    = "terraform.tfstate"
#     region = "ap-south-1"
#   }
# }