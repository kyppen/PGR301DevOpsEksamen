terraform {
  required_version = ">= 1.9" # Specify the version you need
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.74.0" # Specify the provider version if needed
    }
  }
  backend "s3" {
  bucket = "pgr301-2024-terraform-state"
  key    = "sofastate-state-lab.tfstate"
  region = "eu-west-1"
}
}

provider "aws" {
  region = "eu-west-1" # or any region you prefer
}
