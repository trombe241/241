terraform {
  required_version = "~> 1.2.4"

  /*
  backend "s3" {
    region = "ap-northeast-1"
    bucket = "tfstate-share"
    key    = "/terraform.tfstate"

    dynamodb_table = "state_locking"
  }
  */
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.25"
    }
  }
}