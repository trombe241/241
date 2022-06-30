provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  #  version    = "~> 2.0"
}

provider "aws" {
  alias      = "osaka"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-northeast-3"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region  = "us-west-2"
  alias   = "oregon"
}