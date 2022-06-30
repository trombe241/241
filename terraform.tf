terraform {
  required_version = "~> 1.2.4"

  /*
  backend s3は検証時はコメントアウトしておくこと。
  Terraformで作成したリソースの状態を複数のメンバーで共有するためにtfstateファイルの保管先を指定する。
  詳細は下記参照
   https://www.terraform.io/docs/language/settings/backends/s3.html


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