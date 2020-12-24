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
