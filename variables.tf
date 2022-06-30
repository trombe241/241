variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "rds-db-password" {}
variable "prd-redshift-password" {}
variable "simplead-password" {}
variable "aws_region" {
  default = "ap-northeast-1"
}

data "aws_caller_identity" "self" {}

## Avalabiliry-Zone
variable "availability_zone" {
  type = map(any)

  default = {
    a = "ap-northeast-1a"
    c = "ap-northeast-1c"
    d = "ap-northeast-1d"
  }
}

## iret-gateway
variable "iret-gw" {
  type = map(any)
  default = {
    gw_ty2 = "210.227.234.114/32"
    gw_os1 = "211.16.30.174/32"
    jump   = "54.64.137.251/32"
  }
}

## Managed-GIP
## お客様環境からのアクセスで使用される通信元IPアドレスを定義する。
variable "managed-gip" {
  type = map(any)
  default = {
  }
}

## Project Name
variable "project-name" {
  default = "nishii"
}

## 環境名
variable "env" {
  default = "prd"
}

## VPC-CIDR
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

## VPC-subnet(public and private)
variable "vpc_subnet" {
  type = map(string)

  default = {
    public-a      = "10.0.10.0/24"
    public-c      = "10.0.11.0/24"
    private-a     = "10.0.30.0/24"
    private-c     = "10.0.31.0/24"
    vpn-private-a = "10.0.100.0/24"
    vpn-private-c = "10.0.101.0/24"
  }
}

variable "prd-web" {
  type = map(string)

  default = {
    count = 2
  }
}

variable "bastion" {
  type = map(string)

  default = {
    count = 1
  }
}

variable "bastion-ami" {
  type = list(string)

  default = [
    "ami-0e23e72b7d4fe6ac0",
  ]
}

/*
variable "bastion-subnet" {
  type = list(string)

  default = [
    aws_subnet.public-a.id,
    aws_subnet.public-c.id
  ]
}
*/


## aws account reference
data "aws_caller_identity" "current" {}
