# VPC

## VPC
resource "aws_vpc" "vpc_main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.project-name}-${var.env}-vpc"
  }
}

## Subnet
resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = var.vpc_subnet["public-a"]
  map_public_ip_on_launch = "1"
  availability_zone       = var.availability_zone["a"]

  tags = {
    Name = "${var.project-name}-${var.env}-public-a"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = var.vpc_subnet["public-c"]
  map_public_ip_on_launch = "1"
  availability_zone       = var.availability_zone["c"]

  tags = {
    Name = "${var.project-name}-${var.env}-public-c"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = var.vpc_subnet["private-a"]
  map_public_ip_on_launch = "0"
  availability_zone       = var.availability_zone["a"]

  tags = {
    Name = "${var.project-name}-${var.env}-private-a"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = var.vpc_subnet["private-c"]
  map_public_ip_on_launch = "0"
  availability_zone       = var.availability_zone["c"]

  tags = {
    Name = "${var.project-name}-${var.env}-private-c"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "${var.project-name}-${var.env}-igw"
  }
}

## NAT Gateway
resource "aws_nat_gateway" "natgw-a" {
  allocation_id = aws_eip.natgw-a.id
  subnet_id     = aws_subnet.public-a.id

  tags = {
    Name = "${var.project-name}-${var.env}-natgw-a"
  }
}

## EIP for NAT Gateway
resource "aws_eip" "natgw-a" {
  vpc = true
}

## Route Table
resource "aws_route_table" "public-a-rt" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project-name}-${var.env}-public-a-rt"
  }
}

resource "aws_route_table" "public-c-rt" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project-name}-${var.env}-public-c-rt"
  }
}
/*
resource "aws_route_table" "private-a-rt" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-a.id
  }

  tags = {
    Name = "${var.project-name}-${var.env}-private-a-rt"
  }

}

resource "aws_route_table" "private-c-rt" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-a.id
  }

  tags = {
    Name = "${var.project-name}-${var.env}-private-c-rt"
  }

}
*/
## Route table association with vpc
resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-a-rt.id
}

resource "aws_route_table_association" "public-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public-c-rt.id
}

/*
resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-a-rt.id
}

resource "aws_route_table_association" "private-c" {
  subnet_id      = aws_subnet.private-c.id
  route_table_id = aws_route_table.private-c-rt.id
}
*/