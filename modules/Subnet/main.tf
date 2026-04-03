data "aws_availability_zones" "available" {} #既存であるAZを参照したいのでdataを使用

#--------------------
#pablic
#--------------------


resource "aws_subnet" "public_1a" {
  vpc_id = var.vpc_id

  map_public_ip_on_launch = true

  cidr_block = "10.0.0.0/20"

  availability_zone = data.aws_availability_zones.available.names[0] #上記のAZで参照した（今回は東京リージョン）の０（1a）を指定

  tags = {
    "Name" = "aws-study-subnet-1a"
  }
}

resource "aws_subnet" "public_1c" {

  vpc_id = var.vpc_id

  map_public_ip_on_launch = true

  cidr_block = "10.0.16.0/20"

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" = "aws-study-subnet-1c"
  }
}

#--------------------
#private
#--------------------

resource "aws_subnet" "private_1a" {

  vpc_id = var.vpc_id

  map_public_ip_on_launch = false

  cidr_block = "10.0.128.0/20"

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" = "aws-study-private-1a"
  }


}

resource "aws_subnet" "private_1c" {

  vpc_id = var.vpc_id

  map_public_ip_on_launch = false

  cidr_block = "10.0.144.0/20"

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" = "aws-study-private-1c"
  }


}

#--------------------
#rds
#--------------------

resource "aws_db_subnet_group" "rdsdbsubnetgroup" {

  name = "rdsdbsubnetgroup"

  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id
  ]

  tags = {
    "Name" = "aws-study-rds"
  }
}