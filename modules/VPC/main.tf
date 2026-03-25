

resource "aws_vpc" "vpc" { #resource "リソース種類" "Terraform内の名前"

  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { #tagはcfnとは違いキー型なのでnameだけ
    Name = "aws-study-vpc"
  }
}


